"""A unified async process runner with configurable output handling and robust error management."""

from .core import run_process, configure_logger

__version__ = "0.1.0"
__all__ = ["run_process", "configure_logger"]