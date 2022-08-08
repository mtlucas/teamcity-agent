FROM jetbrains/teamcity-agent:latest

USER root
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-add-repository https://packages.microsoft.com/ubuntu/20.04/prod
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y ansible ant ca-certificates-java iputils-ping maven ruby zip wget powershell nodejs terraform packer vault nuget kubectl mono-roslyn mono-complete mono-dbg msbuild
RUN apt autoremove -y && apt-get upgrade -y
COPY lucasnetCA.crt /usr/local/share/ca-certificates/
RUN keytool -import -alias lucasnet-int -trustcacerts -file /usr/local/share/ca-certificates/lucasnetCA.crt -keystore /opt/java/openjdk/lib/security/cacerts -storepass changeit
RUN update-ca-certificates
