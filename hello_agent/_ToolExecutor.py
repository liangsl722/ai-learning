# -*- coding: utf-8 -*-
"""
@File    : _ToolExecutor.py
@Date    : 2026/4/28
@Author  : Shanglin Liang
@Desc    : 通用的工具执行器
"""

from typing import Dict, Any, Callable


class ToolExecutor:
    """
    工具执行器，负责管理和执行工具
    """
    def __init__(self):
        self.tools: Dict[str, Dict[str, Any]] = {}

    def register_tool(self, name: str, description: str, func: Callable):
        """向工具箱中注册一个新工具"""
        if name in self.tools:
            print(f"WARNING: Tool '{name}' already exists")
        else:
            self.tools[name] = {"description": description, "func": func}
            print(f"INFO: Tool '{name}' has been registered")

    def get_tool(self, name: str) -> Callable:
        """根据名称获取一个工具的执行函数"""
        try:
            return self.tools[name]["func"]
        except KeyError:
            raise ValueError("Tool '{name}' is not registered")

    def get_available_tools(self) -> str:
        """获取所有可用工具的格式化描述字符串"""
        return "\n".join([
            f"- {name}: {info['description']}"
            for name, info in self.tools.items()
        ])