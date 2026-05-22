# -*- coding: utf-8 -*-
"""
@File    : agent.py
@Date    : 2026/5/6
@Author  : Shanglin Liang
@Desc    : Agent基类
"""

from abc import ABC, abstractmethod # 抽象基类机制，定义接口约束，强制子类实现指定方法
from typing import Optional, Any
from .message import Message
from .config import Config
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from _LLM import AgentsLLM


class Agent(ABC):
    def __init__(
            self,
            name: str,
            llm: AgentsLLM,
            system_prompt: Optional[str] = None,
            config: Optional[Config] = None,
    ):
        self.name = name
        self.llm = llm
        self.system_prompt = system_prompt
        self.config = config or Config()
        self._history: list[Message] = []

    # 装饰run方法，强制所有子类必须实现此方法，保证了所有agent都有统一的执行入口
    @abstractmethod
    def run(self, input_text: str, **kwargs) -> str:
        """运行agent"""
        pass

    def add_message(self, message: Message):
        """添加消息到历史记录"""
        self._history.append(message)

    def clear_history(self):
        """清空历史记录"""
        self._history.clear()

    def get_history(self) -> list[Message]:
        """获取历史记录"""
        return self._history.copy()

    def __str__(self) -> str:
        return f"Agent(name={self.name}, provider={self.llm.provider})"