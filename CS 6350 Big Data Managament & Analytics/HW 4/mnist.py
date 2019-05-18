import torchvision
import torch as torch
import numpy as np

torch.__version__# Load data to dataloader

from torchvision import datasets
import torchvision.transforms as transforms

folderbig = "big"
foldersmall = "small"

train_x_location = "x_train_18_10.csv"
train_y_location =  "y_train_18_10.csv"
test_x_location = folderbig + "/" + "x_test.csv"
test_y_location = folderbig + "/" + "y_test.csv"

print("Reading training data")
x_train_2d = np.loadtxt(train_x_location, dtype="uint8", delimiter=",")
x_train_3d = x_train_2d.reshape(-1,28,28,1)
x_train = x_train_3d
y_train = np.loadtxt(train_y_location, dtype="uint8", delimiter=",")

train_loader = torch.utils.data.DataLoader(train_data, batch_size=batch)
test_loader = torch.utils.data.DataLoader(test_data, batch_size=batch)
