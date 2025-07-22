# Async Runner

A unified async process runner with configurable output handling and robust error management.

This package provides a clean, efficient way to run subprocesses asynchronously using anyio, with optional output capture, logging integration, and comprehensive error handling.

## Features

- **Async Process Execution**: Built on anyio for efficient async subprocess management
- **Configurable Output Handling**: Choose whether to capture and log stdout/stderr
- **Robust Error Management**: Comprehensive exception handling and process failure detection
- **Custom Logger Support**: Integrate with your existing logging infrastructure
- **Session Control**: Option to start processes in new sessions
- **Clean API**: Simple `run_process()` function for easy integration
- **100% Test Coverage**: Thoroughly tested for reliability and stability

## Why Use Divine Async Runner?

### Process Management Made Simple
Running subprocesses asynchronously can be complex, especially when you need to handle output streaming, error logging, and process lifecycle management. Divine Async Runner abstracts away this complexity into a single, reliable function.

### Production-Ready Error Handling
The library handles various edge cases including:
- Process failures with detailed error reporting
- Stream reading exceptions
- Task cancellation scenarios
- Resource cleanup

### Flexible Integration
- Drop-in replacement for basic subprocess calls
- Optional logger configuration for existing applications
- Minimal dependencies (only anyio required)

## Installation

```bash
# For end users
pip install divine-async-runner

# For development
poetry install
```

## Usage

### Basic Usage

```python
import asyncio
from async_runner import run_process

async def main():
    # Simple command execution
    success = await run_process(["echo", "Hello World"])
    print(f"Command succeeded: {success}")

    # Command with arguments
    success = await run_process(["python", "--version"])
    print(f"Python version check: {success}")

asyncio.run(main())
```

### With Output Capture

```python
import asyncio
from async_runner import run_process

async def main():
    # Capture and log output
    success = await run_process(
        ["ls", "-la"],
        capture_output=True,
        process_name="Directory Listing"
    )
    print(f"Directory listing completed: {success}")

asyncio.run(main())
```

### Custom Logger Integration

```python
import asyncio
import logging
from async_runner import run_process, configure_logger

class CustomLogger:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
    
    def info(self, message: str) -> None:
        self.logger.info(message)
    
    def error(self, message: str) -> None:
        self.logger.error(message)
    
    def warning(self, message: str) -> None:
        self.logger.warning(message)

async def main():
    # Configure custom logger
    configure_logger(CustomLogger())
    
    # Run process with custom logging
    success = await run_process(
        ["python", "-c", "print('Hello from Python')"],
        capture_output=True,
        process_name="Python Script"
    )

asyncio.run(main())
```

### Advanced Usage

```python
import asyncio
from async_runner import run_process

async def main():
    # Start process in new session (useful for daemons)
    success = await run_process(
        ["python", "-m", "http.server", "8000"],
        start_new_session=True,
        capture_output=True,
        process_name="HTTP Server"
    )
    
    # Handle process failure
    if not success:
        print("Server failed to start")

asyncio.run(main())
```

## API Reference

### `run_process(command, *, capture_output=False, start_new_session=False, process_name="Unknown")`

Run a subprocess asynchronously.

**Parameters:**
- `command` (List[str]): Command and arguments to execute
- `capture_output` (bool): Whether to capture and log stdout/stderr (default: False)
- `start_new_session` (bool): Whether to start in a new session (default: False)
- `process_name` (str): Name for logging purposes (default: "Unknown")

**Returns:**
- `bool`: True if process completed successfully (return code 0), False otherwise

### `configure_logger(logger)`

Configure a custom logger for the async runner.

**Parameters:**
- `logger`: Logger instance implementing the Logger protocol (info, error, warning methods)

## Error Handling

The library handles several types of errors gracefully:

```python
import asyncio
from async_runner import run_process

async def main():
    # Process that will fail
    success = await run_process(["nonexistent-command"])
    if not success:
        print("Command failed or doesn't exist")
    
    # Process with non-zero exit code
    success = await run_process(["python", "-c", "exit(1)"])
    if not success:
        print("Process returned non-zero exit code")

asyncio.run(main())
```

## Contributing

Contributions are welcome! Please ensure all changes include appropriate tests to maintain 100% coverage.

## Real-World Examples

Check out the `examples/` directory for practical use cases:

- **Basic Usage**: Simple subprocess execution
- **Output Processing**: Capturing and processing command output
- **Logger Integration**: Using with existing logging systems
- **Error Handling**: Robust error handling patterns

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Security

For security concerns, please see [SECURITY.md](SECURITY.md).