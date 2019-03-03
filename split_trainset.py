import os
import glob
from os.path import join, isfile
from random import shuffle

data_dir = 'train'
files = glob.glob(join(data_dir, '*.png'))

train_file = open('train.txt', 'w')
valid_file = open('valid.txt', 'w')

# 20% for validation
valid_size = 0.2
count = 0
shuffle(files)

for _f in files:
  if count != round(len(files) * valid_size):
    valid_file.write(_f + '\n')
    count = count + 1
  else:
    train_file.write(_f + '\n')

train_file.close()
valid_file.close()
