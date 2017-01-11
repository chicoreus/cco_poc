#!make

# timestamp for the database-export
TS := $(shell date '+%Y_%m_%d_%H_%M')

# credentials for the database
DB=cco_full
DB_USER=xxx
DB_PSW=yyy

copy-mysql:
	@echo "remember to update the credentials in the file before running 'build' "
	@cp config/liquibase_cco_full.properties.mysqltemplate config/liquibase_cco_full.properties

copy-postgreSQL:
	@echo "remember to update the credentials in the file before running 'build' "
	@cp config/liquibase_cco_full.properties.postgresqltemplate config/liquibase_cco_full.properties

build:
	@echo "Running Liquibase ... " 
	@mvn clean install

clean:
	@echo "remove... " 
	@mvn clean 

create_db:
	mysql -u ${DB_USER} -p${DB_PSW} -e "create database IF NOT EXISTS ${MYSQL_DB};"

drop_db:
	mysql -u ${DB_USER} -p${DB_PSW} -e "drop database IF EXISTS ${MYSQL_DB};"

dump_db:
	mysqldump -u ${DB_USER} -p${DB_PSW} ${DB} > ${DB}-dump-$(TS).sql
