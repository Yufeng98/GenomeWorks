import sys

log_filename = sys.argv[1]
f = open(log_filename, 'r')
lines = f.readlines()
runtime = 0
for line in lines:
    if line[:7] == "cudapoa":
        lst = line.split()
        runtime += float(lst[-2])
print("cudapoa kernel runtime: {:.2f}".format(runtime))