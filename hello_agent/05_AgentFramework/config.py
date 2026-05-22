# -*- coding: utf-8 -*-
"""
@File    : config.py
@Date    : 2026/5/6
@Author  : Shanglin Liang
@Desc    : 配置管理
"""

import os
from typing import Optional, Any, Dict
from pydantic import BaseModel


class Config(BaseModel):
    # LLM配置
    default_model: str = "llama-3.3-70b-versatile"
    default_provider: str = "openai"
    temperature: float = 0.7
    max_tokens: Optional[int] = None

    # 系统配置
    debug: bool = False
    log_level: str = "INFO"

    # 历史管理配置
    max_history_length: int = 100

    @classmethod
    def from_env(cls) -> "Config":
        """从环境变量中创建配置"""
        return cls(
            debug=os.getenv("DEBUG", "false").lower() == "true",
            log_level=os.getenv("LOG_LEVEL", "INFO"),
            temperature=float(os.getenv("TEMPERATURE", "0.7")),
            max_tokens=int(os.getenv("MAX_TOKENS")) if os.getenv("MAX_TOKENS") else None,
        )

    def to_dict(self) -> Dict[str, Any]:
        """转换为字典"""
        return self.model_dump()