#!/usr/bin/env bash

# Este script é para facilitar a configuração da VPN com a HDI

function vpn-youse() {
  case $1 in
#    connect)
#      docker run -ti --rm --privileged --name openconnect --net=host openconnect ./openconnect --protocol=gp vpn.hdi.com.br
#    ;;  
    config)
      sudo ip route del default via 192.168.191.1 dev tun0
      #sudo ip route add 10.0.0.0/8 dev vpn0 metric 100
      #sudo ip route add 34.95.135.113/32 dev vpn0 # Acesso ao Spinnaker
      #sudo systemd-resolve -i vpn0 --set-dns=10.7.0.71 --set-dns=10.7.1.15 --set-dns=10.7.0.72 --set-domain=hdi.com.br --set-domain=hdi.br --set-domain=santanderauto.com.br --set-domain=hdiseguros.com.br --set-domain=hdi-gerling.com.br
    ;;  
    *)  
      echo "Uso incorreto. Use os parâmetros connect|config apenas."
    ;;  
  esac
}
