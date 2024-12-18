import numpy as np
import math
import matplotlib.pyplot as plt

class mp_neuron():
	def __init__(self):
		pass

	def sum_input(self,inputs=[]):
		self.input_total = sum(inputs)
		self.n_inputs = len(inputs)
		return self.input_total

	def set_theta(self,gate_type):
		self.gate_type = gate_type
		if self.gate_type == 'AND':
			self.theta = self.n_inputs	
		if self.gate_type == 'OR':
			self.theta = 1#fill in relevant threshold	(Hint: do you need to manually update this based on number of inputs or is there a variable that you can use here?)
		return self.theta

	def compare_threshold(self,input_sum):

		if self.input_total >= self.theta:
			self.y = 1
		else:
			self.y = 0

		return self.y # return the output

#Create MP neuron
mp = mp_neuron()		

#User updated values
input_values = [1, 0, 1, 0, 1, 1]		#Try changing these values to test different scenarios, add or remove inputs - how would that change theta?
gate_type = 'NOR'			#Fill in different valid gate types to test

#Run network
input_sum = mp.sum_input(input_values)
mp.set_theta(gate_type)
output = mp.compare_threshold(input_sum)
print ("The output of the network is:")
print(output)
