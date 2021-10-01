import os
import numpy as np
import pandas as pd
directory = "SupplementaryFiles"

fileNames = []
for filename in os.listdir(directory):
    fileNames.append(filename)

fileNames.sort()

dataFrames = []
for fileName in fileNames:
    file = open(directory + "/" + fileName, 'r')
    Lines = file.readlines()
    file.close()
    counter = 0
    rowName = ""
    columnNames = []
    rowValues = []

    for line in Lines:
        if counter == 0:
            rowName = line.strip()
            counter += 1
            continue
        try:
            fields = line.split('\t')
            columnNames.append(fields[0])
            rowValues.append(fields[1].strip())
        #for one last file that was delimited by a space
        except IndexError:
            print(fileName, line)
            fields = line.split(' ')
            columnNames.append(fields[0])
            rowValues.append(fields[1].strip())
    rowValues = np.asarray(rowValues)
    df = pd.DataFrame(rowValues.reshape(-1, len(rowValues)), columns=columnNames) #, index=rowName
    df = df.rename(index={0: rowName})
    dataFrames.append(df)

combinedDataFrame = pd.concat(dataFrames)
print(combinedDataFrame.head(10))
print(len(combinedDataFrame))
combinedDataFrame.to_csv('CombinedSamples.csv')
