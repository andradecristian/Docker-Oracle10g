FROM docker.io/candrade1981/ol5:v02

USER root

RUN groupadd -g 501 oinstall \
  && groupadd -g 502 dba \
  && groupadd -g 503 oper \
  && groupadd -g 504 asmadmin \
  && groupadd -g 505 asmdba \
  && groupadd -g 506 asmoper \
  && groupadd -g 507 bkpdba \
  && groupadd -g 508 dgdba \
  && groupadd -g 509 kmdba \
  && useradd -m -g oinstall -G oinstall,dba,oper,asmadmin,asmdba,bkpdba,dgdba,kmdba -u 501 oracle



# Make sure all requirements are met and install a few useful additional packages
COPY software/*tar.gz /install/
COPY scripts/* /home/oracle/bin/


RUN echo "oracle           ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers \
  && echo "Defaults !requiretty"  >> /etc/sudoers \
  && mkdir -p /u01/app/oracle \
  && mkdir -p /home/oracle/bin \
  && chown -R oracle:oinstall /u01/app \
  && chown -R oracle:oinstall /install \
  && chown -R oracle:oinstall /home/oracle/bin \
  && chown -R oracle:oinstall /install \
  && chown -R oracle:oinstall /home/oracle/bin/*.rsp \
  && chown -R oracle:oinstall /home/oracle/bin/*.sh \
  && chmod u+rx /home/oracle/bin/*.sh \
  && /home/oracle/bin/initdbconf.sh

# Switch to user Oracle
USER oracle
WORKDIR /install

# set current environment
ENV ORACLE_BASE=/u01/app/oracle
ENV ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
ENV PATH=/u01/app/oracle/product/10.2.0/db_1/bin:$PATH
ENV LD_LIBRARY_PATH=/u01/app/oracle/product/10.2.0/db_1/lib:$LD_LIBRARY_PATH
ENV NLS_DATE_FORMAT=dd/mm/yyyy:hh24:mi:ss
ENV DISABLE_HUGETLBFS=1

# Unzip software
RUN cd /install \
  && tar -zxvf 10201_database_linux64.tar.gz

RUN tar -zxvf p8202632_10205_Linux-x86-64.tar.gz


RUN /install/database/runInstaller -silent -force -waitforcompletion -responsefile /home/oracle/bin/db_install.rsp -ignoresysprereqs -ignoreprereq

# Switch back to root
#
USER root
RUN /u01/app/oracle/oraInventory/orainstRoot.sh \
  && /u01/app/oracle/product/10.2.0/db_1/root.sh -silent \
  && rm -rf /install/database \
  && echo "export DISABLE_HUGETLBFS=1" >> /home/oracle/.bashrc


USER oracle

RUN cd /install/Disk1 \
  && ./runInstaller -waitForCompletion -silent -responseFile /home/oracle/bin/patch_install.rsp -ignoresysprereqs -ignoreprereq

RUN cd /install \
  && rm -rf Disk1



EXPOSE 1521

USER oracle
WORKDIR /home/oracle

# set current environment
ENV ORACLE_BASE=/u01/app/oracle
ENV ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
ENV PATH=/u01/app/oracle/product/10.2.0/db_1/bin:$PATH
ENV NLS_DATE_FORMAT=dd/mm/yyyy:hh24:mi:ss
ENV DISABLE_HUGETLBFS=1

##
 RUN cd /home/oracle/bin \
 && ./create-db.sh -d DEV -a N

CMD ["/usr/bin/bash"]
