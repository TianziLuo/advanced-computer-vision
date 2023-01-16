########################################################################
# 2. DEFINE YOUR CONVOLUTIONAL NEURAL NETWORK
########################################################################

import torch.nn as nn
import torch.nn.functional as F


class ConvNet(nn.Module):
    def __init__(self, init_weights=False):
        super(ConvNet, self).__init__()
        # INITIALIZE LAYERS HERE
        self.conv_layer = nn.Sequential(

            # Layer 1
            nn.Conv2d(in_channels=3, out_channels=32,
                      kernel_size=3, padding=1),

            nn.BatchNorm2d(32),                                    # batch normalization
            nn.ReLU(),                                             # activation

            # Layer 2
            nn.Conv2d(in_channels=32, out_channels=64,
                      kernel_size=3, padding=1),

            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=2, stride=2),                 # choose max value in 2x2 area

            # Layer 3
            nn.Conv2d(in_channels=64, out_channels=128,
                      kernel_size=3, padding=1),

            nn.BatchNorm2d(128),
            nn.ReLU(),
            nn.Dropout2d(p=0.05),

            # Layer 4
            nn.Conv2d(in_channels=128, out_channels=256,
                      kernel_size=3, padding=1),

            nn.BatchNorm2d(256),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=2, stride=2),
        )

        self.fc_layer = nn.Sequential(
            # fc layer 1
            nn.Dropout(p=0.1),
            nn.Linear(256*8*8, 512),
            nn.ReLU(),
            # fc layer 2
            nn.Dropout(p=0.1),
            nn.Linear(512, 10),
            nn.ReLU(),
        )

        if init_weights:
            self._initialize_weights()                              # initialize weights of the convolutional layers.

    def forward(self, x):
        # PASS IMAGE X THROUGH EACH LAYER DEFINED ABOVE
        # conv layers
        out = self.conv_layer(x)
        # flatten
        out = out.view(out.size(0), -1)
        # fc layer
        out = self.fc_layer(out)
        # Softmax
        out = F.log_softmax(out, dim=1)
        return out

    def _initialize_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                nn.init.kaiming_normal_(
                    m.weight, mode='fan_out', nonlinearity='relu')
                if m.bias is not None:
                    nn.init.constant_(m.bias, 0)
            elif isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1)
                nn.init.constant_(m.bias, 0)
            elif isinstance(m, nn.Linear):
                nn.init.normal_(m.weight, 0, 0.01)
                nn.init.constant_(m.bias, 0)
