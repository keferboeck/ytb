YTB Coding Challange Solution
-
**Requirements**

* Ruby = 2.5.3

**Setup**
1. Download zip or clone repository
2. Goto project's folder in your terminal
3. Run `$ bundle install`

**Task 1**

To run the first task run `$ ruby bin/runner.rb - l`

**Task 2**

To run the second task run `$ ruby bin/runner.rb - a`

**Additional**

There are additional parameters that can be added to the programme.

`$ ruby bin/runner.rb **-c** [-radius Integer] [-filter_by column country] [-sort_by id]`

Example: If you wish to search for all individuals located Wales in a radius of 300km from Brighton

`$ ruby bin/runner.rb -c -radius 300 -filter_by country wales`

**Comments**

The main idea should remain the changeability of the application at hand, as it usually is the only metric that counts. The classes all have a single responsibility and are independent (except for Task, yet the dependency is one directional). 

I prefer to remove argument-order dependencies on any public interface of a class. I understand that this may differ from other people's practices. However, even you limit the parameter list and only allow methods to be public that is stable, the argument list may change, and you end up with bugs that could otherwise be avoided.

I spent close to two hours on writing the application my efforts within a decent timeframe. The lack of time left the app with some known issues and incomplete implementation.

_Known Issues_

1. `People#sort_by` fails when the column picked is a hash (value of a key). Hence, the rescue.
2. `Interface#print_table` order of column headings is not linked to the actual column value
3. The Task class is somewhat experimental and comparable to a spike. There is a violation when it comes to dependency injection given an object of each, People and Interface, are created within. The dependencies have been isolated by moving the creation to private methods to highlight this.
4. The way chaining in `Task#one` and `Task#two` may not be pretty, yet, the changing has been implemented considering that the next step in the evolution of the programme is more flexibility so the user can define how to filter and search the list (see. Additional). 

_Required Improvements_

1. People know too much about the JSON format and may not cope well if the format changes (especially when it comes to location).
2. Error handling. Exceptions are being raised, yet little thought has been given towards a rescue path. I do not believe everything should be blindly rescued within an application - therefore this bit is left open.

_Incomplete_ 

1. There are no tests for `Task`
2. There are no tests for `Interface`

Mainly because both classes had been added in a spike towards the end of writing, they require cleaning up, respectively a rewrite anyway with testing first.

3. Note that I only test messages of the public interface, as testing anything private that is unstable and likely to change is a duplication, given it is part of the test of a publicly available message, and thereby only ads cost (writing specs, maintaining them, etc.)
