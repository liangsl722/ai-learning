# AI Learning Journey

> 记录从 Prompt 工程到深度学习、从框架使用到自主实现的 AI 学习之路。

## 目录结构

| 模块                                                         | 说明                                                                | 状态 |
|------------------------------------------------------------|-------------------------------------------------------------------|------|
| [prompt engineering](./prompt%20engineering)               | Prompt 工程核心技巧与 Chatbot 实践                                         | ✅ 已完成 |
| [langchain_1](./langchain_1)                               | LangChain 框架基础（模板/记忆/链/评估/Agent）                                  | ✅ 已完成 |
| [langchain_WithPersonalData](./langchain_WithPersonalData) | LangChain + 个人文档（加载/分块/向量/检索/对话）                                  | ✅ 已完成 |
| [hello_agent](./hello_agent)                               | Agent 设计模式与自研框架<br/>（ReAct/Plan-and-Solve/Reflection/LangGraph/Memory） | ✅ 已完成 |
| [rag](./rag)                                               | 从零构建 RAG 系统                                                       | ✅ 已完成 |
| [torch](./torch)                                           | PyTorch 深度学习基础到 Transformer / LLM                                 | ✅ 已完成 |
| [diffusion](./diffusion)                                   | 扩散模型                                                              | ⬜ 待开始 |
| <!-- 新模块 -->                                               | <!-- 在此添加新的学习模块 -->                                               | ⬜ 待开始 |

---

## 各模块详情

### 1. Prompt Engineering

学习如何编写高质量的 Prompt，掌握与大模型交互的基本功。

| 编号 | 主题 | 关键内容 |
|------|------|----------|
| 01 | Guidelines | 分隔符、结构化输出、条件检查、Few-shot 提示 |
| 02 | Iterative | 迭代优化 Prompt 流程 |
| 03 | Summarizing | 文本摘要策略 |
| 04 | Inferring | 推断与信息提取 |
| 05 | Transforming | 文本转换（翻译/格式化等） |
| 06 | Expanding | 文本扩展与生成 |
| 07 | Chatbot | 多轮对话机器人（system/user/assistant 角色管理） |

### 2. LangChain 基础

学习 LangChain 框架的核心组件与使用方式。

| 编号 | 主题 | 关键内容 |
|------|------|----------|
| 01 | Prompt Template & Output Parser | ChatPromptTemplate、输出解析器 |
| 02 | Memory | 对话记忆管理 |
| 03 | Chains | 链式调用组合 |
| 04 | Q&A | 基础问答链 |
| 05 | Evaluation | 输出评估方法 |
| 06 | Agent | LangChain Agent + 内置工具（llm-math / wikipedia） |

### 3. LangChain + 个人数据

学习如何让 LLM 基于私有文档进行问答与对话。

| 编号 | 主题 | 关键内容 |
|------|------|----------|
| 01 | Document Load | 多源文档加载（PDF / YouTube / Web / Notion） |
| 02 | Splitting | 文本分块策略 |
| 03 | Vectorstores & Embeddings | 向量存储与嵌入（Chroma + HuggingFace） |
| 04 | Retrieval | 检索策略 |
| 05 | Q&A | 基于文档的问答 |
| 06 | Chat | 记忆 + 对话检索链 + 个人文档聊天机器人 |

### 4. Agent 模式与框架

深入理解 Agent 的设计模式，并从零搭建自己的 Agent 框架。

| 编号 | 主题 | 关键内容 |
|------|------|----------|
| 01 | ReAct | Thought→Action→Observation 循环、优缺点分析 |
| 02 | Plan and Solve | 先规划再执行的多步推理模式 |
| 03 | Reflection | 自我反思与迭代改进 |
| 04 | LangGraph | 基于图的状态编排 |
| 05 | Agent Framework | 自研 Agent 框架（见下方详解） |
| 06 | Memory & RAG | 记忆系统设计（4 种记忆类型）+ RAG 分析 |

#### 自研 Agent 框架 (`hello_agent/05_AgentFramework/`)

从零实现了一个可扩展的 Agent 框架，核心组件：

```
05_AgentFramework/
├── agent.py            # Agent 抽象基类（统一执行入口 + 消息历史管理）
├── config.py           # Pydantic 配置管理（支持环境变量加载）
├── message.py          # 消息系统（user/assistant/system/tool 四种角色）
├── my_llm.py           # LLM 调用封装
├── my_simple_agent.py  # 简单 Agent 实现
├── my_react_agent.py   # ReAct Agent 实现（优化 Prompt + 工具注册集成）
├── test_simple_agent.ipynb
└── test_react_agent.ipynb
```

**辅助模块：**

- `_ToolExecutor.py` — 工具执行器：注册 / 查询 / 调用工具
- `_Tool_search.py` — SerpAPI 网页搜索工具实现
- `_LLM.py` — LLM 调用封装

### 5. RAG 实验

从零构建检索增强生成系统，不依赖 LangChain 等高层框架。

| 文件 | 说明 |
|------|------|
| `rag_experiment.ipynb` | 完整 RAG 流程：文档加载 → 文本分块 → 向量嵌入 → FAISS 索引 → 检索生成 |
| `rag_data/` | 实验数据（时序预测领域的中文经验文档） |

**技术栈：** sentence-transformers (all-MiniLM-L6-v2) + FAISS + Ollama (qwen2.5:7b)

### 6. PyTorch 深度学习

从张量基础到 Transformer 架构与 LLM 模型演进的完整学习路径。

| 编号 | 主题 | 关键内容 |
|------|------|----------|
| 01 | Tensor | 张量基础（1D/2D/3D）、维度含义（B, L, D） |
| 02 | Logistic Regression | 逻辑回归 |
| 03 | Neural Network | 全连接神经网络 |
| 04 | Optimize | 优化算法 |
| 05 | CNN | 卷积神经网络 |
| 06 | ResNet | 残差网络 |
| 07 | Transfer Learning | 迁移学习 |
| 08 | RNN | 循环神经网络 |
| 09 | Transformer | Attention 公式推导、Multi-Head Attention 手动实现 |
| 10 | LLM Models | GPT-1/2/3/4 与 BERT 架构演进 |

**模型产出：** `runs/` 目录下保存了训练好的 Transformer 翻译模型与 BPE 分词器。

---

## 学习进度追踪

### 已掌握的技能

- [x] Prompt 工程核心技巧（分隔符、Few-shot、结构化输出）
- [x] 多轮对话与 Chatbot 构建
- [x] LangChain 框架核心组件（模板 / 记忆 / 链 / Agent）
- [x] 文档加载、分块、向量嵌入与检索
- [x] 基于个人文档的问答与聊天系统
- [x] Agent 设计模式（ReAct / Plan-and-Solve / Reflection）
- [x] 自研 Agent 框架（抽象基类 + 工具注册 + 消息系统）
- [x] 从零构建 RAG 系统（FAISS + sentence-transformers）
- [x] 记忆系统设计（Working / Episodic / Semantic / Perceptual）
- [x] PyTorch 基础到 Transformer 架构
- [x] LLM 模型演进（GPT 系列 / BERT）

### 下一步计划

- [ ] Diffusion model
- [ ] ...

---

## 环境与依赖

- **Python** — 主要编程语言
- **PyTorch** — 深度学习框架
- **LangChain** — LLM 应用框架
- **Ollama** — 本地大模型服务（qwen2.5:7b 等）
- **FAISS / Chroma** — 向量数据库
- **sentence-transformers** — 文本嵌入模型
- **SerpAPI** — 搜索引擎 API
- **Pydantic** — 数据校验与配置管理

> 详细依赖请参考各模块的 notebook 及 `.env` 配置。

---

## 项目约定

- 各模块以编号前缀排序，体现学习顺序
- Notebook 为主要学习载体，含代码与笔记
- `.env` / `.env.*` 已在 `.gitignore` 中排除，API Key 不会提交
- `data/`、`checkpoints/`、`weights/` 已在 `.gitignore` 中排除
