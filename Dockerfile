FROM registry.redhat.io/rhscl/nodejs-10-rhel7
USER root

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

# install the Oracle dependencies./tmp/oracle_fdw-ORACLE_FDW_2_0_0/oracle_fdw.control
COPY oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
COPY oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm

RUN yum -y install oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    yum -y install oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm


# change back to the regular user
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib

# set the oracle library path
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib:${LD_LIBRARY_PATH}

EXPOSE 8080
CMD [ "node", "bin/www" ]
