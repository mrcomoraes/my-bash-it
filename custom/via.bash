function via_ocp3_exibir_hpa() {
  if [ "$2" == "-m" ]
  then
    while true
    do
      echo "Monitoramento HPA - $1"
      oc get hpa -n $1 --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
      echo -e "\n"
      sleep 30
    done
  fi
  
  echo "Monitoramento HPA - $1"
  oc get hpa -n $1 --no-headers | awk -v date="$(date "+%d/%m/%Y - %T")" '{ if($6>$4) print date,"\tMinimo: ",$4,"\tMaximo: ",$5,"\tAtual: "$6,"\tPorcentagem: ",$3,"\tDeployment: ",$1}'
}

#function via_synckubeconfig() {
#  rsync -rtD $HOME/.kube/ /mnt/c/Users/2160000724/Documents/MobaXterm/home/.kube/
#}

