# l2-technology : how to install sensei node from command line

TESTED ON UBUNTU 21.10/20.04

## create user with sudo

```
useradd -m -s /bin/bash -G sudo randomuser
passwd randomuser
su - randomuser
```

## install rust

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

then exit your shell and relogin with your user
```
exit
su randomuser
```

## install docker
```

sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
  
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
    
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```


```
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
exit
```

```
su randomuser
docker run hello-world
```

## install docker-compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  

sudo chmod +x /usr/local/bin/docker-compose
```

## install ngiri

```
curl https://getnigiri.vulpem.com | bash
```

```
nigiri start
```

> Starting bitcoin ... done  
> Starting electrs ... done  
> Starting chopsticks ... done  
> Starting esplora    ... done  
> ENDPOINTS  
> chopsticks localhost:3000  
> bitcoin localhost:18443  
> bitcoin localhost:18444  
> bitcoin localhost:28332  
> bitcoin localhost:28333  
> electrs localhost:50000  
> electrs localhost:30000  
> esplora localhost:5000  


### ports really used

```
50000 is for electrum, 5000 is esplora, 5401 is for managing sensei node via http, and 50000 is maybe for rpc
```

## install node 16

```
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y gcc g++ make
sudo apt install -y nodejs
node -v
npm -v
```



## install l2 sensei from git

```
git clone https://github.com/L2-Technology/sensei.git
cd sensei/web-admin && npm install && npm run build && cd ..
cargo run --bin senseid -- --network=regtest --electrum-url=localhost:50000
```

## access to web interface

>http://localhost:5401/admin/nodes

### Ressources

https://docs.l2.technology/get-started
https://github.com/L2-Technology/sensei
https://www.rust-lang.org/tools/install  
https://discord.com/channels/939176500966596618/939176691757113404  
https://bitcoindevkit.org/bdk-cli/regtest/  
https://bitcoindevkit.org/  
https://lightningdevkit.org/  
https://nigiri.vulpem.com/  
