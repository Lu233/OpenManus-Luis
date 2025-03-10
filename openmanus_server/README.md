# OpenManus-server 🤖

This project provides a server based on [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) that exposes **OpenManus** tool functionalities as standardized APIs.

## ✨ Features

This MCP server provides access to the following OpenManus tools:

1. **Browser Automation** 🌐 - Navigate webpages, click elements, input text, and more
2. **Google Search** 🔍 - Execute searches and retrieve result links
3. **Python Code Execution** 🐍 - Run Python code in a secure environment
4. **File Saving** 💾 - Save content to local files
5. **Termination Control** 🛑 - Control program execution flow

## 🚀 Installation

### Prerequisites

- Python 3.10+ 
- OpenManus project dependencies

### Installation Steps

1. First, install the OpenManus project:

```bash
git clone https://github.com/mannaandpoem/OpenManus.git
cd OpenManus
```

2. Install dependencies:

```bash
# Using uv (recommended)
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv
source .venv/bin/activate  # Unix/macOS
# or .venv\Scripts\activate  # Windows
uv sync
```

3. Install MCP dependencies:

```bash
pip install mcp-python
```

## 📖 Usage

### Starting the MCP Server

The server supports two communication modes: stdio and HTTP.

#### stdio mode (default)

```bash
python mcp_server.py
```

#### HTTP mode

```bash
python mcp_server.py --transport http --host 127.0.0.1 --port 8000
```

### Command Line Arguments

- `--transport`: Communication method, choose "stdio" or "http" (default: stdio)
- `--host`: HTTP server host address (default: 127.0.0.1)
- `--port`: HTTP server port (default: 8000)

## 💻 Client Example

Check out `mcp_client_example.py` to learn how to connect to the server and call tools using the MCP client.

### Running the Client Example

1. First, start the server in HTTP mode:

```bash
python mcp_server.py --transport http
```

2. In another terminal, run the client example:

```bash
python mcp_client_example.py
```

## 🤖 LLM Integration

The MCP server can be integrated with LLMs that support tool calling, such as Claude 3 Opus/Sonnet/Haiku.

### Example with Claude

```python
import anthropic
from mcp.client import MCPClient

# Initialize Claude client
client = anthropic.Anthropic(api_key="your_api_key")

# Connect to MCP server
mcp_client = await MCPClient.create_http("http://localhost:8000")

# Get tool definitions
tools = await mcp_client.list_tools()
tool_definitions = [tool.to_dict() for tool in tools]

# Create Claude message
message = client.messages.create(
    model="claude-3-opus-20240229",
    max_tokens=1000,
    temperature=0,
    system="You are a helpful assistant that can use tools to help users.",
    messages=[{"role": "user", "content": "Search for Model Context Protocol and summarize the top 3 results"}],
    tools=tool_definitions
)

# Handle tool calls
for tool_call in message.content:
    if hasattr(tool_call, "tool_use"):
        tool_name = tool_call.tool_use.name
        tool_params = tool_call.tool_use.input
        
        # Call MCP tool
        result = await mcp_client.invoke_tool(tool_name, tool_params)
        
        # Send results back to Claude
        message = client.messages.create(
            model="claude-3-opus-20240229",
            max_tokens=1000,
            temperature=0,
            system="You are a helpful assistant that can use tools to help users.",
            messages=[
                {"role": "user", "content": "Search for Model Context Protocol and summarize the top 3 results"},
                {"role": "assistant", "content": [tool_call]},
                {"role": "user", "content": [{"type": "tool_result", "tool_use_id": tool_call.tool_use.id, "content": result}]}
            ],
            tools=tool_definitions
        )
```

## 🔒 Security Considerations

- By default, the HTTP server only listens on localhost (127.0.0.1) and is not exposed externally
- When using in production, ensure proper authentication and authorization mechanisms are in place
- The Python execution tool has timeout limits to prevent long-running code

## 📄 License

Same license as the OpenManus project 