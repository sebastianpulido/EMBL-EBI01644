# EMBL-EBI01644
Alternatives:
- 1. Use Enseml REST API
		
	e.g. http://rest.ensembl.org/map/human/GRCh38/1:942451..942451:1/GRCh37?
	
	output: 
	
		mappings: 
		  - 
		    mapped: 
		      assembly: GRCh37
		      coord_system: chromosome
		      end: 877831
		      seq_region_name: 1
		      start: 877831
		      strand: 1
		    original: 
		      assembly: GRCh38
		      coord_system: chromosome
		      end: 942451
		      seq_region_name: 1
		      start: 942451
		      strand: 1
		
	Advantages:
	
		- Can be called from any web browser.
		- It can be access within a script in a programmatically way (using our favourite scripting language).
		- Provides flexibility and lower maintenance costs.
		
	Disadvantages:
	
		- There might be some extra latency.


- 2. Web Server listening for requests to convert from GRCh38 to GRCh37

	e.g. webserver.py
	
	Usage: http://localhost:5000/item/get_suggest?query=a&species=a&limit=10

		Dependecies / Libraries

		#!/usr/bin/python3
		from flask import Flask
		from flask import jsonify
		from flask import request
		from flask import render_template
		import json
		import mysql.connector
		from mysql.connector import Error
		
	output:
	
		['5S_rRNA', '5_8S_rRNA', 'a1cf', 'A3GALT2', 'aaas', 'aacs', 'aadac', 'aadacl4', 'aadat', 'aagab']
	
	Description:
	
		This web server implemente in Python & Flask
		connects directly to Ensembl database,
		build and SQL command and returns the resultset.

		Note that this script DOES NOT convert coordinates.
		It is just an example of how to connect to Ensembl database and
		execute queries.

		Advantages:
		- Can be called from any web browser.

		Disadvantages:
		- Knowledge of the database tables, schemas, etc is necessary.
		
- 3. A client or wrapper script written in Python
		
	e.g. cmdapp_cli.py (converts default values from GRCh38 to GRCh37 only)
	
	Usage: python3 cmdapp_cli.py -c 10 -f 25000 -t 30000

		Dependecies / Libraries
		
		#!/usr/bin/python3
		import click 
		import os
		import subprocess
		
		This script calls the script written in PERL which
		converts coordinates from GRCh38 to GRCh37.
		It uses Click in order to received arguments from the command line.
		
		Advantages:
		- It is convenient because it is a popular programming / scripting language.
		
		Disadvantages:
		- It does not have any logic regarding the coversion, therefore,
		in order to extend the functionality of the script, requieres some effort.

