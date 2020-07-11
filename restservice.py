#!/usr/bin/python3
from flask import Flask
from flask import jsonify
from flask import request
from flask import render_template
import json
import random
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

@app.route("/")
def main():
    # prints test database
    return jsonify({'db':getDB()})

# test json-based test database
def getDB():
    with open('genebase.json', 'r') as db:
        genebase = json.load(db)

    for gene in genebase:
        print(gene['dataset'])

    return genebase

# return all item in test database
@app.route('/item/genes',methods=['GET'])
def getItems():
    items=getDB()
    return jsonify({'items':items})

# return a list of hardcoded test IDs (degugging)
def getIDs():
    return ["101","201","301"]

# get random suggests from test database 
@app.route('/item/get_random_suggest',methods=['GET','POST'])
def getRandomSuggest():
    ID = random.choice(getIDs())
    gene = [ i for i in getDB() if (i['id'] == ID) ]
    return jsonify({'i':gene})

# get data from real online database
def getDB2(query, species, limit):
    try:
        connection = mysql.connector.connect(host='ensembldb.ensembl.org',
                                            database='ensembl_website_97',
                                            user='anonymous',
                                            port=3306)

        if connection.is_connected():
            db_Info = connection.get_server_info()
            print("Connected to MySQL Server version ", db_Info)
            cursor = connection.cursor()
            cmd = cmdBuilder(query, species, limit)
            cursor.execute(cmd)
            result = cursor.fetchall()

            genes = ""
            list = []
            for row in result:
                genes += str(row[1]) + "\n"
                list.append(row[1])
            
            print(genes)
            return str(list)

    except Error as e:
        print("Error while connecting to MySQL", e)
    finally:
        if (connection.is_connected()):
            cursor.close()
            connection.close()
            print("MySQL connection is closed")

def cmdBuilder(query, species, limit):
    # 13,499,312 species
    cmd = " select distinct species, display_label from ensembl_website_97.gene_autocomplete where 1=1"
    if(str(species) != ""):
        cmd += " and species like '%" + str(species) + "%'"
    if(str(query) != ""):
        cmd += " and display_label like '%" + str(query) + "%'"
    if(str(limit) != ""):
        cmd += " limit " + str(limit) + ";"
    return cmd
    

# get suggests based on service params
@app.route('/item/get_suggest',methods=['GET','POST'])
def getSuggest():
    query = ""
    species = ""
    limit = ""
    if 'query' in request.args:
        query = request.args['query']
        print("query",query)
    if 'species' in request.args:
        species = request.args['species']
        print("species",species)
    if 'limit' in request.args:
        limit = request.args['limit']
        print("limit",limit)
    return getDB2(query, species, limit)

if __name__ == "__main__":
    app.run()
