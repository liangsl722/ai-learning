# -*- coding: utf-8 -*-
"""
@File    : my_llm.py
@Date    : 2026/5/6
@Author  : Shanglin Liang
@Desc    : 在继承_LLM.py定义的AgentsLLM基础上，增加对modelscope平台的支持
"""

import sys, os
from typing import Optional
from openai import OpenAI
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from _LLM import AgentsLLM


class MyLLM(AgentsLLM):
    """
    一个自定义的LLM客户端，通过继承增加了对ModelScope的支持。
    当用户传入 provider="modelscope" 时，执行我们自定义的逻辑；
    否则，就调用父类 HelloAgentsLLM 的原始逻辑，使其能够继续支持 OpenAI 等其他内置的供应商
    """
    def __init__(
            self,
            model: Optional[str]=None,
            api_key: Optional[str]=None,
            base_url: Optional[str]=None,
            provider: Optional[str]=None,
            **kwargs,
    ):
        # 检查 provider 是否为想要处理的 'modelscope'
        if provider == "modelscope":
            print("正在使用自定义的 ModelScope Provider")
            self.provider = "modelscope"

            # 解析凭证
            self.api_key = api_key or os.getenv("MODELSCOPE_API_KEY")
            self.base_url = base_url or os.getenv("MODELSCOPE_BASE_URL")

            # 验证凭证是否存在
            if not self.api_key:
                raise ValueError("ModelScope API key not found. Please set MODELSCOPE_API_KEY environment variable.")

            # 设置默认模型和其他参数
            self.model = model or "Qwen/Qwen2.5-VL-72B-Instruct:DashScope"
            self.temperature = kwargs.get("temperature", 0.7)
            self.max_token = kwargs.get("max_token")
            self.timeout = kwargs.get("timeout", 60)

            # 使用以上参数通过openai SDK 创建client实例
            self.client = OpenAI(api_key=self.api_key, base_url=self.base_url, timeout=self.timeout)

        elif provider == "ollama":
            print("正在使用 Ollama 本地模型")
            self.provider = "ollama"

            # Ollama 不需要 API Key
            self.api_key = "ollama"   # 随便填，SDK要求有值
            self.base_url = base_url or "http://localhost:11434/v1"

            self.model = model or os.getenv("OLLAMA_MODEL_ID")
            self.temperature = kwargs.get("temperature", 0.7)
            self.timeout = kwargs.get("timeout", 60)

            self.client = OpenAI(
                api_key=self.api_key,
                base_url=self.base_url,
                timeout=self.timeout
            )

        else:
            # 如果不是 modelscope，则完全使用父类的原始逻辑来处理
            super().__init__(model=model, api_key=api_key, base_url=base_url, **kwargs)



if __name__ == "__main__":
    from dotenv import load_dotenv
    load_dotenv()

    # 实例化重写的client，并指定provider
    # llm = MyLLM(provider="modelscope")
    llm = MyLLM(provider="ollama")

    messages = [{"role": "user", "content": "介绍你自己"}]

    # 调用，think等方法已从父类中继承，无需重写
    response_stream = llm.think(messages)

    # 打印响应
    print("ModelScope Response: ↑")
    for message in response_stream:
        pass