#!/usr/bin/python3
import click

@click.command()
@click.option("--name", prompt="type gene name or << exit >> to terminate", help="type gene name or << exit >> to terminate")

def welcome(name):
    if name == "gen1":
        print("information for gen1")
        loop(0)
    elif name == "gen2":
        print("information for gene2")
        loop(0)
    elif name == "exit":
        loop(1)
    else:
        print("gene name not found.")
        loop(0)

def loop(i):
    while(i == 0):
        welcome()

if __name__ == '__main__':
    print("Human Genome Overview")
    print("https://www.ncbi.nlm.nih.gov/grc/human")
    loop(0)