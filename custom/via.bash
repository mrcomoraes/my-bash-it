function via_ocp3_exibir_hpa() {
  if [ -z "$1" ]
  then
    echo "Está faltando parâmetro do namespace."
  elif [ "$2" == "-m" ]
  then
    while true
    do
      echo "Monitoramento HPA - $1"
      oc get hpa -n $1 --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
      echo -e "\n"
      sleep 30
    done
  else
    echo "Monitoramento HPA - $1"
    oc get hpa -n $1 --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
  fi
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

#function via_synckubeconfig() {
#  rsync -rtD $HOME/.kube/ /mnt/c/Users/2160000724/Documents/MobaXterm/home/.kube/
#}

