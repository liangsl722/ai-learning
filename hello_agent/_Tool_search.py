# -*- coding: utf-8 -*-
"""
@File    : 00_Tool_search.py
@Date    : 2026/4/28
@Author  : Shanglin Liang
@Desc    : 定义一个tool: search in google
"""

"""
工具三要素：
1. 名称 name：简洁、唯一的标识符，供agent在action中调用，例如 Search
2. 描述 description：清晰的自然语言描述这个工具的用途，大模型会依赖这段描述来判断何时使用哪个工具
3. 执行逻辑 execution logic：真正执行任务的函数或方法
"""


import serpapi
import os


def search(query: str) -> str:
    """
    基于SerpAPI的网页搜索引擎工具
    解析搜索结果，优先返回直接答案或知识图谱信息。
    :param query: 提问
    :return:
    """
    print(f"%%% 正在执行 SerpApi 网页搜索：{query}")
    try:
        load_dotenv()
        api_key = os.getenv("SERPAPI_API_KEY")
        if not api_key:
            return "error: there is no SERPAPI_API_KEY in .env file"

        params = {
            "engine": "google",
            "q": query,
            "gl": "cn", # 国家代码
            "hl": "zh-cn", # 语言代码
        }

        client = serpapi.Client(api_key=api_key)
        results = client.search(params)

        # 解析：优先寻找最直接的答案
        if "answer_box_list" in results:
            return "\n".join(results["answer_box_list"])
        if "answer_box" in results and "answer" in results["answer_box"]:
            return results["answer_box"]["answer"]
        if "knowledge_graph" in results and "description" in results["knowledge_graph"]:
            return results["knowledge_graph"]["description"]
        if "organic_results" in results and results["organic_results"]:
            # 如果没有直接答案，则返回前三个有机结果的摘要
            snippets = [
                f"[{i + 1}] {res.get('title', '')}\n{res.get('snippet', '')}"
                for i, res in enumerate(results["organic_results"][:3])
            ]
            return "\n\n".join(snippets)

        return f"FAILURE: DON'T find {query}"

    except Exception as e:
        return f"ERROR: {e}"



if __name__ == "__main__":
    from _ToolExecutor import ToolExecutor
    from dotenv import load_dotenv
    load_dotenv()

    # 初始化工具执行器
    toolExecutor = ToolExecutor()

    # 注册网页搜索引擎工具
    search_description = "一个网页搜索引擎工具。当需要回答关于时事、事实以及在知识库中找不到的信息时，应使用此工具。"
    toolExecutor.register_tool(
        name="Search",
        description=search_description,
        func=search,
    )

    # 打印可用的工具情况
    print("\n--- 可用的工具 ---")
    print(toolExecutor.get_available_tools())

    # 模拟agent的action调用，问一个实时性的问题
    print("\n--- 执行 Action：Search[“英伟达最新的GUP型号是什么”] ---")
    tool_name = "Search"
    tool_input = "英伟达最新的GUP型号是什么"
    tool_function = toolExecutor.get_tool(tool_name)
    if tool_function:
        observation = tool_function(tool_input)
        print("--- Observation ---")
        print(observation)
    else:
        print(f"ERROR: {tool_name} not found.")













