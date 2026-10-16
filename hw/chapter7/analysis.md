# Chapter 7 CPU Scheduling Assignment

## Q1 — Basic Scheduler Comparison
**Jobs:** lengths = [100, 200, 300], all arrive at time 0, seed = 1234

### FIFO
- Execution order: Job 0 → Job 1 → Job 2
- Avg Turnaround Time: 333.33
- Avg Response Time: 133.33
- Avg Wait Time: 133.33
- **Analysis**: 按到达顺序运行到完成，实现简单无额外开销。但响应时间随任务位置线性增加，后续任务等待久，存在护航效应。

### SJF
- Execution order: Job 0 → Job 1 → Job 2
- Avg Turnaround Time: 333.33
- Avg Response Time: 133.33
- Avg Wait Time: 133.33
- **Analysis**: 当前任务顺序已是最短优先，故与 FIFO 结果相同。若打乱顺序（如 300, 100, 200），SJF 平均周转时间会显著优于 FIFO。SJF 在非抢占式调度中能最小化平均周转时间。

### RR (Quantum = 10)
- Avg Turnaround Time: 456.67
- Avg Response Time: 10.00
- Avg Wait Time: 256.67
- **Analysis**: 响应时间极快且公平，适合交互式系统。但频繁切换导致总完成时间拉长，平均周转时间比 FIFO/SJF 高出约 37%，整体吞吐量下降。时间片越小 → 响应越快但切换开销越大。

## Summary
- **FIFO**: 最简单、无开销；但不公平，短任务可能等很久
- **SJF**: 最优平均周转；需预知任务长度，对长任务不友好
- **RR**: 响应公平低延迟，交互体验好；上下文切换开销大，周转时间更长