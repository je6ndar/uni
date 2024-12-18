import numpy as np
import matplotlib.pyplot as plt
from random import random

class Perceptron():
    def __init__(self):
        """
        Perceptron neuron model
        Parameters
        ----------
        n_inputs : int
            Number of inputs
        weights : array
            Weights of the Perceptron - to be learned
        training_input : array
            Input for the Perceptron to learn the weights
        """
        n_inputs =
        self.weights =  		       # initialize weight array with random values
        self.training_input =          # insert an array of training values - 2 inputs per training set

    def activation_function(self, input_total):
        """
         It computes the activation `a` given an input `input_total`
         TODO: Fill in the activation function of your choice
        """
        pass
        return a


    def train_weights(self, gate_type, bias, iterations, learning_rate):
        """
         It learns the weights based on the specified gate type
         TODO: Fill in the update of the weights by first predicting the output based on the gate type
               and then calculating the error
        """
        num_input_sets = np.shape(self.training_input)[0]

        if gate_type== 'OR':
            self.desired_output =   # fill in desired output based on gate type
        elif gate_type == 'AND':
            self.desired_output =    # fill in desired output based on gate type
        elif gate_type == 'NAND':
            self.desired_output =    # fill in desired output based on gate type
        for i in range(iterations):
            for j in range(num_input_sets):
                perceptron_input =    # calculate the input to the perceptron
                perceptron_output =
                error =                 #calculate the error
                #Update each of the weights

        return perceptron_output

    def test_network(self, bias, input_value):
        """
         It computes the output `perceptron_output` based on `bias` and `input_value`
         TODO: Fill in the function to predict the output of the Perceptron
        """
        perceptron_input =   #calculate the input to the perceptron using the learned weights
        perceptron_output =  #calculate the output of the perceptron based on the input
        return perceptron_output

#User input
bias =                      #fill in
training_iterations =       #fill in
learning_rate =             #fill in
test_input =                #fill in

# Create neuron **************ALL CODE FROM THIS POINT AND BELOW DOES NOT NEED TO BE UPDATED**************************************
per = Perceptron()
gate_type = ['OR','AND','NAND']

#Compare test input to training values for plotting
test_value_array=[]
for i in range(4):
	test_value_array.append(np.array_equal(per.training_input[i],test_input))
test_index = test_value_array.index(1)

for i in range(3):
    neuron_output = per.train_weights(gate_type[i],bias,training_iterations,learning_rate)	#Find weights
    network_output = per.test_network(bias,test_input)					#Test network
    print('You selected a(n)',gate_type[i],'gate','with an input of',test_input,'; The network output is',round(network_output))
    #Plot the desired output and the actual output
    plt.plot(per.desired_output[test_index],'bo')
    plt.plot(network_output,'ro')
    plt.xticks([0], [per.training_input[test_index]])
    plt.xlabel('Gate input')
    plt.ylabel('Network output')
    plt.xlim((-1, 4))
    plt.ylim((-0.5, 1.5))
    plt.legend(['Desired', 'Output'])
    plt.title(gate_type[i])
    plt.show()

