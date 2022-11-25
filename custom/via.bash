function via_ocp4_exibir_hpa() {
  if [ -z "$1" ]
  then
    echo "Está faltando parâmetro do namespace."
    return 1
  fi
  for op in "$@"; do
    if [ "$op" == "-m" ]; then
      MONITORING=true
    else
      PROJECT="$op"
    fi
  done

  if [ "$MONITORING" == "true" ]
  then
    while true
    do
      echo "Monitoramento HPA - $PROJECT"
      oc get hpa -n "$PROJECT" --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
      echo -e "\n"
      sleep 30
    done
  else
    echo "Monitoramento HPA - $PROJECT"
    oc get hpa -n "$PROJECT" --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
  fi
}

function via_ocp4_get_nodes_requests {
  if [ -z "$1" ]; then
    echo "Está faltando o nome do projeto como parâmetro!"
    return 1
  elif ! oc get project "$1" &> /dev/null; then
    echo "Projeto não encontrado."
    return 1
  else
    local nodes
    local label
    label=$(oc get project "$1" -o yaml | yq '.metadata.annotations."openshift.io/node-selector"')
    nodes=$(oc get nodes --no-headers -o custom-columns=NAME:metadata.name -l "$label")

  fi
  local node_count=0
  local total_percent_cpu=0
  local total_percent_mem=0

  for n in $nodes; do
    local requests
    requests=$(oc describe node "$n" | grep -A3 -E "\\s\sRequests" | tail -n2)
    local percent_cpu
    # shellcheck disable=SC2086
    percent_cpu=$(echo $requests | awk -F "[()%]" '{print $2}')
    local percent_mem
    # shellcheck disable=SC2086
    percent_mem=$(echo $requests | awk -F "[()%]" '{print $8}')
    echo -e "$n: ${percent_cpu}% CPU, ${percent_mem}% memory"

    ((node_count++))
    total_percent_cpu=$((total_percent_cpu + percent_cpu))
    total_percent_mem=$((total_percent_mem + percent_mem))
  done

  local avg_percent_cpu
  avg_percent_cpu=$((total_percent_cpu / node_count))
  local avg_percent_mem
  avg_percent_mem=$((total_percent_mem / node_count))

  echo -e "\e[1mAverage usage: ${avg_percent_cpu}% CPU, ${avg_percent_mem}% memory.\e[m"
}

function via_aks_get_nodes_requests {
  if [ -z "$1" ]; then
    echo "Está faltando o nome do namespace como parâmetro!"
    return 1
  elif ! kubectl get ns "$1" &> /dev/null; then
    echo "Projeto não encontrado."
    return 1
  else
    local nodes
    local label
    label="app=${1%-*}"
    nodes=$(kubectl get nodes --no-headers -o custom-columns=NAME:metadata.name -l "$label")

  fi
  local node_count=0
  local total_percent_cpu=0
  local total_percent_mem=0

  for n in $nodes; do
    local requests
    requests=$(kubectl describe node "$n" | grep -A3 -E "\\s\sRequests" | tail -n2)
    local percent_cpu
    # shellcheck disable=SC2086
    percent_cpu=$(echo $requests | awk -F "[()%]" '{print $2}')
    local percent_mem
    # shellcheck disable=SC2086
    percent_mem=$(echo $requests | awk -F "[()%]" '{print $8}')
    echo -e "$n: ${percent_cpu}% CPU, ${percent_mem}% memory"

    ((node_count++))
    total_percent_cpu=$((total_percent_cpu + percent_cpu))
    total_percent_mem=$((total_percent_mem + percent_mem))
  done

  local avg_percent_cpu
  avg_percent_cpu=$((total_percent_cpu / node_count))
  local avg_percent_mem
  avg_percent_mem=$((total_percent_mem / node_count))

  echo -e "\e[1mAverage usage: ${avg_percent_cpu}% CPU, ${avg_percent_mem}% memory.\e[m"
}

function via_vpn {
  case "$1" in
    wifi)
      INTERFACE=wlp2s0
    ;;

    cabo)
      INTERFACE=eno1
    ;;

    *)
      echo "Utilize $0 (cabo|wifi) como parâmetro."
      exit 1
    ;;
  esac

  sudo ip route add 10.0.0.0/8 via 192.168.10.91 dev "$INTERFACE"
  sudo ip addr add 192.168.137.2/24 dev "$INTERFACE"

  if [ "$2" == "fora" ]; then
    sudo systemd-resolve -i "$INTERFACE" --set-dns=10.128.8.75 --set-dns=10.128.8.76
  fi
}
