# RAG\(Retrieval Augmented Generation\)

# 体系结构

1. Prompt

2. **Retriever** \<=\> Knowledge Database

3. Relevant Documents

4. Augmented Prompt: original prompt \+ retrieved information

5. **LLM**: response

# Retriever

## Keyword Search

根据prompt中的关键词在文档中出现的频率，对文档评分和排序，进行匹配

### TF\-IDF

Term Frequency \- Inverse Document Frequency

- Inverted index：

    - 每一列代表一个不同的文档，每一行代表一个不同的词语

    - 从词出发，查找哪些文档包含该词；可以在搜索前一次性创建好

- Term Frequency：

    - 词语在该文档中出现的频率

- Inverse Document Frequency：

    - log\(所有文档数 / 包含有该词的文档数\)

    - IDF本质是对TF的加权

### BM25

BestMatching25

$IDF*\frac{TF*(k_1+1)}{TF+k_1*(1-b+b*\frac{文档长度}{平均文档长度})}$

- 词频饱和（term frequency saturation）：对关键词额外出现次数进行折扣；

- 文档长度归一化（document length normalization）：随着文档长度增加，逐步减少额外的惩罚力度，只要长文档中关键词频率较高，仍能得到较高的得分，避免像TF\-IDF那样过于激进

- 超参数：

    - k1：控制文档因重复关键词获得奖励的速度，一般1\.2\~2\.0，值越大词频的影响越强，一般短文本k1小一点，长文本检索k1稍大；

    - b：控制因文档长度增加受到惩罚的速度，0\~1，一般b选0\.75

## Semantic Search

- 需要将文档或提示词输入一个特殊的embedding model，将词语映射到向量空间中，使语义相近的词聚集到一起；

- Word Embedding Model, Sentence Embedding Model, Document Embedding Model处理不同类型的输入；

- 相似度根据欧氏距离或余弦相似度，测量prompt和各文档之间的距离，返回排序得到最近的文档，即语义最相近的文档。

### Embedding models

- 正负样本对训练：正样本对是两段相似的文本，它们应该被嵌入到彼此很近的位置；负样本对含义完全不同，应该被嵌入到距离更远的位置。嵌入模型确保正样本对最终更靠近，负样本对最终更远离

## Metadata Filtering

- 根据一些存储在文档元数据中的严格条件缩小检索器返回范围，比如标题、作者、日期、权限等；

- 快速、直接、易理解，但是不能单独使用

## Hybird Search

- 把 关键词搜索、语义搜索、元数据过滤 结合为混合搜索流程：

    - retriever对prompt分别进行关键词和语义搜索，得到两份排序后的文档列表（文档可能在两份列表中同时出现，但排序可能不同）；

    - 接下来，两份列表都经过元数据筛选；

    - 最后将两份列表合并，生成最终统一的排序结果

### Reciprocal Rank Fusion

互惠排序融合算法：

$RRF(d)=\sum_{i}\frac{1}{k+rank_i(d)}$

- 根据文档在不同搜索结果中的排名计算其得分，k通常取60

- RRF只关心文档在每个列表中的排名，而不考虑这些排名的具体分数

### Beta

- 超参数，Weighting Semantic vs Keyword

- 一般初始赋予语义搜索0\.7权重，关键词搜索0\.3权重

- **关键词搜索**实现精确词匹配，**语义搜索**根据含义进行模糊匹配，**元数据过滤**则用严格标准筛除文档

## Quality Metrics

- Precision：准确率

    - Precision = relevant retrieved / total retrieved

- recall：召回率

    - Recall = relevant retrieved / total relevant

    - Recall 或 recall@K 是**最常用**的，反映了找到相关文档的最基础目标

- Top k：在检索器评分最高的k份文件中讨论各metrics，以进行标准化，避免受到检索器返回文档数量影响

    - 通常选择top 5 \~ 15 之间

- MAP：Mean Average Percision

    - MAP@K，评估前 K 个检索结果中相关的平均准确率

    - 前k个结果中，只对包含相关文档的行累加准确率，然后除以前k个结果中相关文档的数量

    - Precision \& MAP **进一步**评估检索器是否包含大量无关文档，以及检索器对文档排序的有效性

- Reciprocal Rank：倒数排名，返回列表中第一个相关对象的排名倒数

    - Reciprocal Rank = 1 / Rank

    - Mean Reciprocal Rank \(MRR\)：多个prompt计算平均值，反映相关结果出现的速度

    - 平均倒数排名 **有助于**判断模型在排名最前端的表现



# Vector Databases

传统的relational databases\(关系型数据库\)是一种结构化的数据存储系统，将信息组织成具有行和列的表格，从而可以基于定义的关系进行管理和查询，如SQL；

Vector database\(向量数据库\)专门存储和检索海量的向量数据，方便进行相似性计算，如Weaviate

## ANN

- k近邻搜索\(k\-nearest neighbor search, KNN\)：

    - 计算prompt向量和每个文档向量之间的距离，排序，返回最近邻的k个文档

    - 每次搜索的计算量随知识库的文档数量**线性增加**

- 近似最近邻\(Approximate Nearest Neighbor, ANN\)：

    - **Navigable Small World**，可导航小世界：

        - 建立邻近图 \(Proximity Graph\)。首先计算每个向量与其他所有向量之间的距离，为每份文档添加一个节点，最后为每份文档与其最近的几个文档之间建立边连接。形成类似网络的结构，在邻近图中沿着边从一个文档跳到最近的另一个文档

        - 收到prompt时，将其向量化，生成查询向量\(query vector\)。在邻近图中的节点中随机选择一个入口点，为候选向量\(candidate vector\)。开始遍历整个图，查看当前候选向量的每个邻居，并计算哪个邻居距离prompt向量最近，然后作为新的候选向量，重复过程直到没有邻居比当前候选更近，返回当前候选。

    - **Hierarchical Navigable Small World \(HNSW\)**，分层可导航小世界：

        - 对于包含1000个文档的知识库，Layer1包含全部1000个向量，并计算邻近图；Layer2随机只保留100个向量，并重新计算邻近图；最后Layer3随机只保留10个向量，并重新计算邻近图。

        - 搜索从最顶层Layer3开始，随机选择一个入口点，找到第三层的最佳候选向量；接着进入Layer2，从第三层找到的最佳候选开始搜索，由于第二层向量更多所以可能又更近的向量，找到第二层的最佳候选；最后进入最低层Layer1，找到最佳候选并返回。

        - 在最高层大步跳跃，在最低层考虑更多的可能。运行时间**对数增长**



## Chunking

- 分块，将知识库中的长文本文档拆分成更小的文本块：

    - Embedding models对可嵌入文本的长度有限制；

    - 可以提升检索器的搜索相关性指标；

    - 确保只将文档中最相关的文本发送给LLM

### **Balancing chunk size**

- Fixed Size Chunking：固定每个块的长度相同

- Overlapping Chunking：允许块之间有重叠，可以减少单词被割裂上下文的情况

- Recursive Character Splitting：递归字符文本分割。选择某个特定字符作为分割点（比如换行符）

### **Semantic Chunking**

- 语义分块，通过逐句遍历文档，将含义相同的句子归为同一个片段

- 对于每一句话，判断是否与前面的句子足够相似，如果相似则归为同一个片段，如果不同则切分为下一个片段。为此，当前片段的内容和下一个句子都会向量化，如果两个向量距离低于某个阈值则说明含义相近，并添加到同一个片段中，持续进行直到当前片段和下一个句子差异过大。此时，进行切分，并从下一个句子重新开始整个流程

### **Language Based Chunking**

- 基于大语言模型分块，本质上黑箱操作

### Context\-Aware Chunking

- 对于任何分块策略的最终优化，都可以使用LLM为每个片段添加上下文信息（片段摘要）

## Query Parsing

对原始prompt解析，识别意图并编辑重写后传递给向量数据库进行检索

### Query Rewriting

- 最简单，最有价值，用LLM在检索前重写查询

- 用精心设计的提示让LLM对用户提交的prompt做基础优化就是最合适的方法

### Named Entity Recognition

- 命名实体识别，识别查询中信息类别的方法，如地址、任务、日期等

- 这些信息随后可用于指导检索器执行向量搜索或元数据筛选

- 比如GLiNER模型

### Hypothetical Document Embedding\(HyDE\)

- 假设性文档嵌入。LLM根据prompt生成一个理想搜索结果的假设性文档，然后将该文档嵌入，其向量表示才是真正用于检索的部分

- 由于检索器其实是在匹配不同类型的文本，所以用理想的假设性文档与知识库中文档匹配



## Encoder

### **Bi\-Encoder**

- 双编码器，用于语义搜索的架构

- prompt和documents是分别嵌入的，因此所有文档都可以提前嵌入，只需要收到prompt后对其本身进行嵌入即可

### **Cross\-Encoder**

- 交叉编码器，能提供比双编码器高得多的文档排序质量

- 在为文档打分时，会将文档和提示拼接，然后将合并后的文本输入一个专用的嵌入模型，模型能够理解提示与文档文本之间深层次的语境互动

- 交叉编码器直接输出相关性分数 0\~1

- 拓展性差，如果知识库中有数十亿文档，每个文档都要和prompt拼接后输入交叉编码器来生成相关性得分

- 质量高，但效率低

### ColBERT

- Contextualized Late Interaction Over BERT，基于BERT的上下文延迟交互。仍然像Bi\-encoder一样提前生成文档向量，但是尝试像Cross\-encoder一样捕捉提示和每个文档之间更深层的交互。

- 不是对整个文档生成一个向量，而是对文档中的每个token（词元）生成一个语义向量；

- 当有prompt输入时，为提示中的每个token生成一个dense vector；

- 评分时，prompt中每个token都会在文档中寻找最相似的token，使其相关性分数最高，把这些最大分数相加即得到该文档的整体相关性分数，即MaxSIM分数

- 问题在于需要存储的向量数量会随着token数量增加



## Re\-ranking

- 重排序，一种检索后的处理方式，对向量数据库初步返回的文档集合（可能存在语义相似但是不直接相关）进行重新排序，以确保返回的文档是最相关的

    - 重排序器通常采用**交叉编码器**架构；

    - 或**基于LLM的重排序**，与交叉编码器类似，但不是将prompt\-document对输入交叉编码器进行重排序，而是直接输入LLM，评估相关性并给出数值相关性分数



# LLM

## Transformer

## Sampling Strategies

### Greedy Decoding

贪婪解码，让LLM不要随机选择，始终选择概率最大的token

- 增加了确定性，但可能陷入重复循环

- 适合代码补全、临时用于系统调试

### Temperature

控制LLM随机性的最常用参数，在softmax计算的概率分布中加入温度系数

$P_i=\frac{e^{z_i/T}}{\Sigma_je^{z_j/T}}$

- temp为1时，是原始分布；

- 较低的temp让分布更尖锐，只有最可能的token才有机会被生产，temp为0时就会执行贪婪解码；

- 较高的temp，1\.1\~1\.3，会让概率更平稳，增加文本生成的随机性

### Advanced Token Sampling

无论如何设置temperature，概率分布右侧都会有长尾，充满无意义的token，为了进一步控制，需要用到一些额外的技术

- **Top\-K sampling**，只允许LLM从概率最高的K个token中选择

- **Top\-P sampling**，限制LLM只能选择累计概率低于某个阈值的token，更灵活

- **Repetition Penalties**，设置重复惩罚，以降低已出现词语的概率

- **Logit Biases**，对数几率偏置，调整特定token的概率

一般的，设置temperature=0\.8，top\_p=0\.9，repetition\_penalty=1\.2：

- 生成代码或回答事实性问题时，较低的temperature和较低的top\-p参数；

- 创意领域时，更高的temperature和top\-p参数；

- 之后可以考虑引入重复惩罚机制、logit偏置或其他采样技术



## LLM Selection

- Model Size：以模型拥有的参数数量来衡量；

- Cost：按token收取费用；

- Context Window：上下文窗口，LLM可处理的最大token数量；

- Latency and Speed：延迟（第一个token响应的时间） 和 速度（每秒处理的token数量）；

- Training Cutoff Date：训练截止日期，模型训练数据所覆盖的最后时间点；

- Quality Metrics：benchmarks，基准测试：

    - Automated（自动化基准测试），针对某一领域的选择题测试、或数学编程题，如MMLU\(大规模多任务语言理解\)；

    - Human\-scoring（人工评分），让两个匿名LLM对同一prompt进行回答，然后请人工评审，如Elo（Elo等级评分系统）、LLM Arena；

    - LLM\-as\-a\-judge（由LLM担任评审），用一个LLM来评判另一个LLM对一组测试题的回答

## Prompt engineering

- **Messages Format**：在代码中构建提示词，最常见的格式是OpenAI的消息格式。通过简单的json结构将prompt组织为一系列消息。

    - 每条message都包括"content"（消息的文本）、"role"（可以是 "system", "user", 或"assistant"）。

        - system message 为模型提供初始指令和背景信息，指导其整体行为和特性；

        - user message 记录系统用户已经发送的prompt，即代表用户的输入或问题

        - assistant message 记录LLM之前生成的回复

- **In\-context learning**：上下文学习，在prompt中添加相关示例，帮助LLM理解你期望的输出类型

    - 直接将一个或多个示例问题和回复硬编码到prompt中；

    - 如果希望每次都更换示例，可以用RAG从是知识库中检索示例问题和回复。将成功的聊天记录索引到向量数据库中，当发起新的对话时检索该话题相关的历史对话文本，并将其注入prompt中

- **Encouraging Reasoning**：鼓励LLM在prompt中进行推理，一步步分析解决问题的最佳方法。本质上是为LLM提供一个scratchpad（草稿区）

    - 告知LLM在草稿标签\<scratchpad\>之间的tokens是思考空间，而不是最终答案的一部分

- **Chain of Thought：思维链**

    - 先生成解答问题所需的步骤，然后按照这些步骤执行

    - **Reasoning Models**：以推理为导向

        - 底层，先生成reasoning tokens，提前规划并权衡各种选项

        - 然后，输出response tokens，向用户呈现最终预期的回答

- **Context Window Management：上下文窗口管理**

    - 对于单轮对话，验证prompt engineering技术是否带来价值，如果链式思维提示或上下文学习没有提升性能，最好直接移除这些组件；

    - 多轮对话会快速消耗上下文窗口，因为每次往返消息都需要包含在prompt中，需要运用**context pruning 上下文剪枝**：

        - 最简单的，在prompt中只保留固定数量的最新消息

    - 如果多轮对话中使用了推理模型，基本都需要从聊天记录中移除reasoning tokens，只保留response tokens

## Hallucinate 

- **Why LLMs hallucinate**

    - LLM生成概率较高的文本序列，并加入了一定的随机性以增加多样性，概率较高的文本序列通知是事实准确的，但并不总是如此，LLM不具备区分真假信息的能力，只能区分概率上的probable和improbable

    - 幻觉分为：混淆细节 和 捏造事实

- **Self\-Consistency Methods：自洽性检查**

    - 让模型对同一prompt多次生成答案，并检查其中的事实信息，判断这些答案中包含的事实信息是否一致

    - 可能贵且不可靠

- **Reducing Hallucinations with RAG**：

    - 最佳方法是**确保回答基于检索到的信息**

    - 比如，修改system prompt，让LLM只能基于检索信息做出事实陈述

    - 进一步，要求LLM对其信息来源进行引用，以确认LLM的回答确实基于检索文档

    - 但是，LLM可能会凭空捏造引用内容

- **ContextCite**：

    - 对回答与一组来源材料的关联程度进行评分的系统

    - 逐句处理回答内容，并将每句话归因于检索到并提供给LLM的上下文文档之一，随后为每句话生成标签，标明该句的来源文档

- **ALCE benchmark**

## Performance evaluation

- **RAGAS**

    - Response Relevancy：回复相关性。衡量回复内容是否真正与用户原始prompt相关，无论其事实准确性如何

        - 首先，将系统生成的response输入到一个新的LLM中，生成几个它认为的可能导致该response的sample prompt；

        - 然后，将原始用户prompt和这些sample prompt都嵌入到语义向量中；

        - 接下来，计算实际用户prompt和每个sample prompt之间的余弦相似性；

        - 最后，将相似度分数取平均，作为最终的回复相关性指标。

    - Faithfulness：真实性。

        - 首先，利用LLM识别response中所有的事实性陈述；

        - 接着，调用更多LLM来判断这些陈述中有多少得到了知识库中检索到的信息的支持

        - 被支持的陈述比例就是真实性度量分数

    - 等等\.\.\.



## Agentic Workflow

代理式工作流，在RAG系统中使用多个LLM，每个模型只负责整体流程中的一个具体步骤

- **Sequential Workflow：顺序型工作流**

    - 输出依次线性地经过一系列LLM，意味着每个发送到系统的prompt都会依次经过基于LLM的parser, re\-writer, citation generator作为生成流程的一部分，每个LLM都只专注于其中一个环节

- **Conditional Workflow：条件型工作流**

    - 用LLM来决定prompt应走哪条路径

- **Iterative Workflow：迭代型工作流**

    - Evaluator LLM对每次结果进行评估，并持续提供反馈，直到认为解决方案合适为止

- **Parallel Workflow：并行型工作流**

    - 编排型\(orchestrator\)LLM将prompt拆分为多个独立任务，并分配给不同的LLM处理

    - 合成型\(synthesizer\)LLM将它们的成功重新整合，输出response



## Fine\-Tuning

- 微调不是拓展prompt，而是对现成的LLM进行再训练，以提升特定场景下的表现

- 核心思想：根据我自有的数据对LLM再训练，更新其内部参数，这一过程称为 **supervised fine\-tuning（有监督微调，SFT）**

- 使模型更专注于某一特定的领域，优化模型在目标领域的表现，而在其他领域上会变差

- 在agentic workflow中，使用轻量级模型，并对其进行大量微调，只让它在单一任务上表现优异

- 微调主要影响模型响应prompt的方式，比如风格、结构等，对于模型掌握的信息影响较小。changes how a model talks, not what it knows\.

- **RAG最适合注入知识，fine\-tuning最适合领域适配，两者结合最佳**

# RAG system production

## Challenge

- Scaling performance: more traffic, more requests

- Unpredictability of prompts

- Messy real world data

- Security and privacy

应对：构建强大的可观测性系统robust observability system



## Observability Platform

这些平台执行常见的评估任务，比如收集系统级或组件级指标，并支持对新系统设置进行实验

- Phoenix，开源可观测与评估平台

    - Traces：追踪一个prompt在整个RAG流程中的路径

    - Evaluation Integration：整合多种评估方法，比如集成用于RAGAS

    - 并不适合监控向量数据库的计算和内存使用情况，可以尝试使用Datadog和Grafana

## Custom dataset of prompts

自定义数据集，是系统处理过的prompts集合，以及选择收集的该prompt在系统中流转的相关信息。储存什么，取决于想要评估什么。

还可以对prompt可视化，经过聚类识别高层主题。

## Quantization

对LLMs和嵌入模型生成的向量进行压缩，量化会用压缩后更低精度的数值代替LLMs中的权重或嵌入向量中的数值，在不明显影响检索相关性或响应质量的情况下更快更便宜

- Integer quantization：整数量化，用更小的整数（比如8\-bit）替换32位浮点数

    - 找到每个维度中出现的最小值和最大值，定义为该维度数值的取值范围；

    - 然后将这个范围均分为256个区间，（256是8\-bits能表示的唯一数值的数量），这些区间分别编号0、1、\.\.\.、255；

    - 原始向量中的每个浮点数都被分配一个整数值，即所在的区间编号；

    - 可以根据最小值和每个区间的宽度还原原始的32位浮点数。

- 1\-bit quantized embedding models：每个维度从32位减少到仅1位

    - 向量中的每个值只有1或0，仅表示该维度的数值是正还是负

    - 用于先进行快速检索，再用完整的32位原始向量重新评分

- Matryoshka quantization：套娃量化，比如在比较相似度时只用部分维度进行操作

    - 原始向量各维度按信息密度高低进行排序，信息指嵌入大量数据时每个维度的统计方差，前面的维度方差大，包含信息量大，因此剔除包含信息少的后面的维度的损失也更少

    - 可以，始终只用前100个维度；

    - 或，初步检索时只用前100个维度，然后再用拉取剩下的900个维度用完整的1000个维度重新评分检索到的初始文档集合



## Cost

- LLM：inference \& generation costs

    - 更小的模型（模型参数量更少，或参数被量化为更低精度的格式）

    - 限制输入和输出的token数量（减少top\_k，或更新prompt以鼓励简洁回答，或设置严格的token上限）；

    - 把LLM部署在专用硬件上

- Vector database：storage \& query costs

    1. RAM，内存：速度最快但成本最高

    2. Disk memory，磁盘存储：介于两者之间

    3. Cloud object storage，云对象存储：最慢但价格最低

    - e\.g\.：HNSW \(hierarchical navigable small world\) index 存放在RAM中，以确保向量检索快速运行；文档内容没必要存放在RAM中，可以将最常访问的文档在磁盘存储，不常访问的对象存放在云盘

    - Multi\-tenancy，多租户机制：根据用户或组织将数据库中的所有文档进行划分，每个用户只能访问自己自己的文档，都会有属于自己的HNSW索引用于关联文档。可以等到用户实际登录时，再将他们的向量加载到内存中。或者可以在低使用时间段将用户数据默认存放在较慢的存储介质中。



## Latency

- 几乎所有的延迟都来自于运行transformer模型，尤其是某些基于transformer的重排序技术：

    - 可以，使用更小或量化后的LLM；

    - 或，使用更小的router LLM \(路由LLM\)，负责分析prompt，决定用小模型还是大模型来处理任务

    - 另外，对于经常收到类似提示的系统，caching \(缓存\) 能有效降低延迟：

        - 维护一个常用prompts及其responses的cache；

        - 当收到新prompt时，快速计算新prompt与缓存中prompt的相似度分数；

        - Direct caching：如果找到足够接近的匹配项则直接返回缓存的responses；

        - Personalized caching：检索缓存的responses后，再将缓存响应和用户提示输入到更小更快的LLM中进行微调，让response更贴合当前prompt

    - 对于其他基于transformer的组件（比如reranker、query\-rewriter、router LLM等），分别测量每个组件为系统增加的延迟，以及它们带来的响应质量提升

- 消除retriever带来的延迟：

    - 在向量数据库中使用二值量化的嵌入，以简化底层的向量距离计算

    - 将数据库分为多个独立实例



## Security

重点是知识库中的信息安全

- 避免 knowledge base leakage：用户可能用一些prompt访问到

    - 根据用户可访问的信息，采用合适的身份验证方式；

    - 基于角色的访问控制，将数据按多租户方式进行隔离。如果用户prompt会导致从向量数据库中检索数据，那么用户只能根据其角色和访问级别访问相关文档。

    - （理论上，可以把所有文档存放在一起，通过metadata filter来确定用户可访问的文档，但元数据过滤最适合用于个性化处理，但并不适用于安全性保障）

- 避免 LLM data leakage：发送给LLM的增强型提示词会包含从知识库中检索到的文本

    - 可以选择在本地完全部署RAG



## Multi\-modal Model

多模态模型是指能够处理多种数据类型的模型

