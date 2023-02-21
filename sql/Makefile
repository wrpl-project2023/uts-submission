ESHOPPING_DBNAME = wrpl_eshopping
ECOMMERCE_DBNAME = wrpl_ecommerce

all: clean setup

clean:
	mysql -e 'DROP DATABASE IF EXISTS $(ESHOPPING_DBNAME)'
	mysql -e 'DROP DATABASE IF EXISTS $(ECOMMERCE_DBNAME)'

setup:
	mysqladmin create $(ESHOPPING_DBNAME) create $(ECOMMERCE_DBNAME)
	cd e_shopping; mysql $(ESHOPPING_DBNAME) < run_all.sql
	cd e_commerce; mysql $(ECOMMERCE_DBNAME) < run_all.sql
