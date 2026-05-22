import os
from openai import OpenAI
from typing import List, Dict



class AgentsLLM:
    """
    定制一个用于该项目的 LLM 客户端，用于调用任何兼容openAI接口的服务，默认使用流式响应
    """
    def __init__(self, model: str = None, api_key: str = None, base_url: str = None, timeout: int = 30):
        """初始化客户端，传入参数或从环境变量加载"""
        self.model = model or os.getenv("LLM_MODEL_ID")
        self.api_key = api_key or os.getenv("LLM_API_KEY")
        self.base_url = base_url or os.getenv("LLM_BASE_URL")
        self.timeout = timeout

        if not all([self.model, self.api_key, self.base_url]):
            raise ValueError("model, api_key and base_url are required")

        self.client = OpenAI(api_key=self.api_key, base_url=self.base_url, timeout=self.timeout)

    def think(self, messages: List[Dict[str, str]], temperature: float = 0.0) -> str:
        """调用大模型进行思考，并返回其响应"""
        print(f"%%% 正在调用 {self.model} 模型...")
        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=messages,
                temperature=temperature,
                stream=True,
            )

            # 处理流式响应
            print("%%% 大语言模型响应成功：")
            collected_content = []
            for chunk in response:
                content = chunk.choices[0].delta.content or ""
                print(content, end="", flush=True)  # print不自动换行，立即刷新终端缓冲区
                collected_content.append(content)
            print() # 流式输出结束后换行
            return "".join(collected_content)

        except Exception as e:
            print(f"！！！ 调用LLM API时发生错误：{e}")
            return None



if __name__ == '__main__':
    from dotenv import load_dotenv
    load_dotenv()

    try:
        llmClient = AgentsLLM()

        example_messages = [
            {"role": "system", "content": "You are a helpful assistant that writes Python code."},
            {"role": "user", "content": "写一个快速排序算法"}
        ]

        print("--- 调用LLM ---")
        response_text = llmClient.think(example_messages)
        if response_text:
            print("\n\n--- 完整模型响应 ---")
            print(response_text)

    except ValueError as e:
        print(e)