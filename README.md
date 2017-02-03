# IBM® Decision Optimization Modeling with OPL and CP Optimizer on DOcplexcloud

Welcome to IBM® Decision Optimization Modeling with OPL and CP Optimizer on DOcplexcloud.


This library contains various model examples with different file types. For each sample you can find here:
* **documentation** - a pdf file describing the optimization problem and the model
* **the model and data files** - a folder containing the .mod, .dat or .ops files


You can solve OPL models with CP Optimizer on DOcplexcloud by
 
- uploading a MOD file with optional JSON file(s) and/or zero or more DAT file(s) and/or zero or more Excel files.
- uploading an OPLPROJECT file with a default run configuration, one or more MOD file(s), zero or more DAT file(s), and an optional OPS file.

An OPL project can have only one default run configuration.

All files must be in the same root directory; uploads containing multiple directories are not supported. Problem files cannot connect to an external data source. You cannot drag and drop files directly from an archive viewer into the DropSolve interface. All files must be dropped on the DropSolve interface simultaneously.

Solving with the IBM Decision Optimization on Cloud service (DOcplexcloud) requires that you
[Register for a DropSolve account](https://dropsolve-oaas.docloud.ibmcloud.com/software/analytics/docloud). You can register for the DOcplexcloud free trial and use it free for 30 days.

## Model descriptions

### House building
How can you schedule a series of tasks of varying durations where some tasks must finish before others start? And assign workers to each of the tasks such that each worker is assigned to only one task at any given time? And maximize the matching of worker skills to the tasks?

To illustrate scheduling of tasks in an optimal way, consider a house building problem in which five houses must be completed by a given date. The construction of each house includes a number of tasks such as installing a roof and painting. Each of these tasks requires a given duration of time from the start to completion of the task. Some tasks must necessarily take place before others; for example, the roofing must be complete before the windows can be installed. Moreover, there are three workers, and each task requires one of the three workers. The three workers have varying levels of skills with regard to the various tasks; if a worker has no skill for a particular task, he cannot be assigned to the task. For some pairs of tasks, if a particular worker performs one of the pair on a house, then the same worker must be assigned to the other of the pair for that house. The objective is to find a solution that maximizes the task-associated skill levels of the workers assigned to the tasks.

This is an example of a scheduling problem in which tasks are represented using a special variable called an interval variable. An interval has a start time, an end time, and a duration. There are special constraints for intervals, including precedence constraints and no overlap constraints, which are used to model this problem.

### Sports scheduling
How can a sports league schedule matches between teams in different divisions such that the teams play each other the appropriate number of times and maximize the objective of scheduling intradivision matches as late as possible in the season?

A sports league with two divisions needs to schedule games such that each team plays every team within its division a given number of times and plays every team in the other division a given number of times. Each week, a team plays exactly one game. The preference is for intradivisional matches to be held as late as possible in the season. To model this preference, there is an incentive for intradivisional matches; this incentive increases exponentially by week. The problem consists of assigning an opponent to each team each week in order to maximize the total of the incentives.

This type of discrete optimization problem can be solved using Integer Programming (IP) or Constraint Programming (CP). Integer Programming is the class of problems defined as the optimization of a linear function, subject to linear constraints over integer variables. Constraint Programming problems generally have discrete decision variables, but the constraints can be logical and the arithmetic expressions are not restricted to being linear.

For comparison purposes this sample is also provided in a format for CPLEX solution.

### Steel mill slab design

How can raw materials be assigned to a batch of orders of different sizes and different processing requirements in order to minimize waste?

A steel mill needs to process a batch of coil orders using steel slabs of varying capacities. Each order has a weight and a color associated with it. The color represents the specific process used to build the coil. A coil order must be built from only one slab. A slab can be used to process multiple coil orders from the batch; however, there can be at most two colors among the set of orders assigned to a given slab.

There is a finite number of slab capacities, but there is an unlimited number of slabs of each size available. The cumulative sum of the weights of the coil orders assigned to a particular slab is called its load. The load assigned to a slab must not exceed the capacity of the slab.

The objective of the problem is to minimize the unused capacity (the loss) of the selected slabs.

This type of discrete optimization problem can be solved using Constraint Programming. Constraint Programming problems generally have discrete decision variables, but the constraints can be logical and the arithmetic expressions are not restricted to being linear.


## License

This library is delivered under the  Apache License Version 2.0, January 2004 (see LICENSE.txt).
