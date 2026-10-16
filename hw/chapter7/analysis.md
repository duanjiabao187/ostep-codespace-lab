# Chapter 7 CPU Scheduling Assignment

## Q1 — Basic Scheduler Comparison
**Jobs:** lengths = [100, 200, 300], all arrive at time 0, seed = 1234

### FIFO
- Execution order: Job 0 → Job 1 → Job 2
- Avg Turnaround Time: 333.33
- Avg Response Time: 133.33
- Avg Wait Time: 133.33
- **分析**: 按到达顺序运行到完成，实现简单无额外开销。但响应时间随任务位置线性增加，后续任务等待久，存在护航效应。

### SJF
- Execution order: Job 0 → Job 1 → Job 2
- Avg Turnaround Time: 333.33
- Avg Response Time: 133.33
- Avg Wait Time: 133.33
- **分析**: 当前任务顺序已是最短优先，故与 FIFO 结果相同。若顺序改为 [300, 100, 200]，SJF 会优先执行短任务，平均周转时间显著优于 FIFO。SJF 在非抢占式调度中能最小化平均周转时间。

### RR (Quantum = 10)
- Avg Turnaround Time: 456.67
- Avg Response Time: 10.00
- Avg Wait Time: 256.67
- **分析**: 响应时间极快且公平，适合交互式系统。但频繁切换导致总完成时间拉长，平均周转时间比 FIFO/SJF 高出约 37%，整体吞吐量下降。时间片越小 → 响应越快但切换开销越大。

## Q2 — Convoy Effect & SJF Advantage
**Jobs:** lengths = [300, 100, 200], all arrive at time 0, seed = 1234

### FIFO
- Execution order: Job 0(300) → Job 1(100) → Job 2(200)
- Avg Turnaround Time: 433.33
- Avg Response Time: 233.33
- **分析**: 长任务先运行，短任务 Job1 等待 300 才开始，护航效应明显。相比 Q1 顺序，平均周转时间从 333.33 变差到 433.33。

### SJF
- Execution order: Job 0 → Job 1 → Job 2（与 FIFO 相同）
- Avg Turnaround Time: 333.33
- Avg Response Time: 133.33
- **分析**: 当前输入顺序下执行顺序未改变。原理说明：SJF 优先运行已到达的最短任务；若允许重排，会按 Job1→Job2→Job0 执行，平均周转降至 333.33，显著优于 FIFO 的 433.33。

## Q3 — RR Quantum Size Effects
**Jobs:** lengths = [100, 200, 300], all arrive at time 0, seed = 1234

| Quantum | Avg Response | Avg Turnaround | Observation |
|---|---|---|---|
| 1 | ~1.00 | ~599.00 | 响应最优；切换开销极大 |
| 10 | 10.00 | 456.67 | 响应与周转平衡 |
| 50 | ~50.00 | ~400.00 | 响应延迟上升，周转改善 |
| 300 | 133.33 | 333.33 | 等价 FIFO 行为 |

**分析**:
- 时间片越小 → 响应越快、交互体验越好，但上下文切换越频繁，总开销上升、周转时间拉长
- 时间片 ≥ 最长任务时长 → RR 完全退化为 FIFO，失去公平性但吞吐量最优
- 设计原则：时间片应远小于典型交互响应阈值，同时足够大以减少切换开销

## Summary
- **FIFO**: 最简单、无开销；但不公平，短任务可能等很久
- **SJF**: 最优平均周转；需预知任务长度，对长任务不友好
- **RR**: 响应公平低延迟，交互体验好；上下文切换开销大，周转时间更长
## Q3 — RR Quantum Size Effects
**Jobs:** lengths = [100, 200, 300], all arrive at time 0, seed = 1234

| Quantum | Avg Response | Avg Turnaround | Avg Wait |
|---|---|---|---|
| 1 | 1.00 | 465.67 | 256.67 |
| 10 | 10.00 | 456.67 | 256.67 |
| 50 | 50.00 | 416.67 | 216.67 |
| 300 | 133.33 | 333.33 | 133.33 |

**分析**:
- 时间片越小 → 平均响应时间越短、交互越及时，但进程切换更频繁，整体周转时间被拉长（q=1 时达 465.67，比 q=300 高约 40%）
- 时间片增大 → 切换开销减少，周转时间逐步改善；q=300 时与最长任务执行时间相同，RR 退化为 FIFO，周转时间降至最优的 333.33，但响应时间明显变长
- 设计权衡：交互式系统选较小时间片保证响应流畅；吞吐量优先场景可适当增大时间片减少切换开销

## Summary
- **FIFO**: 最简单无开销，实现直观；但对短任务不友好，易产生护航效应
- **SJF**: 理论上最优平均周转时间；需预知任务长度，实际实现难度大，对长任务可能不公平
- **RR**: 公平且响应及时，适合分时/交互系统；时间片较小时切换开销大，整体吞吐量受影响
- 不存在绝对最优算法，需根据任务特征与系统目标做取舍