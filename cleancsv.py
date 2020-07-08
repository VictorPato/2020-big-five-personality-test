import csv

with open('data-final.csv') as csvfile:
    with open('new-data.csv','w') as newcsv:
        datareader = csv.reader(csvfile, delimiter='\t')
        datawriter = csv.writer(newcsv, delimiter='\t')
        count = 0
        for row in datareader:
            if count == 0:
                count = 1
                continue
            if 'NULL' in row:
                continue
            # revisar si tiene 0s (50 a 99)
            valid = True
            for time in row[50:100]:
                if int(time) <= 0:
                    valid = False
                    break
            if valid:
                datawriter.writerow(row)

print('tada')
            