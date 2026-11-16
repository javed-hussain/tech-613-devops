# Performance Testing

Evaluates a system’s speed, stability, and scalability under different workloads.

Load testing: Can the system handle the **expected** demand.  
Stress testing: Where are its limits, and how does it recover?

Load Testing:
- Tests performance under expected workloads, including expected peak usage.
- Measures response times, throughput (requests processed per second), error rates, and resource usage.
- Checks whether the system meets performance requirements.
- Example: Simulate 1,000 concurrent users if this is the expected peak.

Stress Testing:
- Pushes the system beyond its expected workload or normal capacity.
- Identifies bottlenecks, capacity limits, and breaking points.
- Checks how the system fails and recovers when load decreases.
- Example: Increase concurrent users beyond 1,000 until performance degrades or the system fails.

### Load testing with apache bench
- Apache Bench (ab) is a lightweight command-line tool for benchmarking and load-testing HTTP servers. 
- It sends a specified number of requests, optionally with multiple concurrent requests, and reports metrics such as requests per second, latency, failures, and HTTP status codes.
- Installation: `sudo apt install apache2-utils`
-  Basic usage: `ab -n 100 -c 10 http://localhost:3000/`
   -  ab is the apache bench command, -n number of reqs, -c concurrent reqs, address = url of destination
  
![report](/Images/ab_report.png)