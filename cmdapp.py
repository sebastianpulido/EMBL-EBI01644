#!/usr/bin/python3
import click 
import os

@click.command()
@click.option("-c","--chromosome", prompt="type chromosome (e.g. 10)")
@click.option("-f", "--frm", prompt="from (e.g. 25000)")
@click.option("-t", "--to", prompt="to (e.g. 30000)")

def welcome(chromosome, frm, to):
    print("chromosome:", chromosome)
    print("from:", frm)
    print("to:", to)
    loop(0)

def loop(i):
    if i == 0: welcome()
    

if __name__ == '__main__':
    print("Human Genome Overview")
    print("https://www.ncbi.nlm.nih.gov/grc/human")
    # os.system("python3 restservice.py")
    loop(0)

# https://github.com/pallets/click