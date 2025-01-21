FROM amd64/fedora:latest

WORKDIR /data-interchange

COPY ./ ./

RUN dnf -y upgrade 
RUN dnf -y install iptables firewalld nftables
RUN echo 'export PATH="$PATH:/usr/bin"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/bin"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/local/bin"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/include"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/include"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/local/include"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/local/include"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/bin/go/bin"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/bin/go/bin"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/lib"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/lib"' >> /etc/skel/.bashrc
RUN echo 'export PATH="$PATH:/usr/local/lib"' >> ~/.bashrc && echo 'export PATH="$PATH:/usr/local/lib"' >> /etc/skel/.bashrc
RUN wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz && tar --extract --file ./*.gz --verbose
RUN mv ./go1.23.4.linux-amd64/go /usr/bin
RUN go env 
RUN go list ./source
RUN go vet ./source
RUN go fix ./source
RUN go fmt ./source
RUN go vet ./source
RUN GOOS=linux GOARCH=amd64 go build -o ./binary/htdinet ./source/main.go
