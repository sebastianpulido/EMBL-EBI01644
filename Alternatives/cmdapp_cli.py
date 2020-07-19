#!/usr/bin/python3
import click 
import os
import subprocess

@click.command()
@click.option("-c","--chromosome", prompt="type chromosome (e.g. 10)")
@click.option("-f", "--frm", prompt="from (e.g. 25000)")
@click.option("-t", "--to", prompt="to (e.g. 30000)")

def welcome(chromosome, frm, to):
    proc = subprocess.Popen(["/usr/bin/env perl", "./connect2ensemble.pl"], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    print ("program output:", out)

def loop(i):
    if i == 0: welcome()

if __name__ == '__main__':
    print("Human Genome Overview")
    print("https://www.ncbi.nlm.nih.gov/grc/human")
    loop(0)