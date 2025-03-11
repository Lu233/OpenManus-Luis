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
uv pip install -r requirements.txt
```

3. Install MCP dependencies:

```bash
uv pip install -r openmanus_server/mcp_requirements.txt
```

## Demo display
<video src="./assets/demo.mp4" data-canonical-src="./assets/demo.mp4" controls="controls" muted="muted" class="d-block rounded-bottom-2 border-top width-fit" style="max-height:640px; min-height: 200px"></video>



## 📖 Usage

### Testing your server with Claude for Desktop

<Note>
Claude for Desktop is not yet available on Linux. Linux users can build an MCP client that connects to the server we just built.
</Note>

First, make sure you have Claude for Desktop installed. [You can install the latest version
here.](https://claude.ai/download) If you already have Claude for Desktop, **make sure it's updated to the latest version.**

We'll need to configure Claude for Desktop for this server you want to use. To do this, open your Claude for Desktop App configuration at `~/Library/Application Support/Claude/claude_desktop_config.json` in a text editor. Make sure to create the file if it doesn't exist.

```
vim ~/Library/Application\ Support/Claude/claude_desktop_config.json
```
You'll then add your servers in the mcpServers key. The MCP UI elements will only show up in Claude for Desktop if at least one server is properly configured.

In this case, we'll add our single Openmanus server like so:
```
{
    "mcpServers": {
        "openmanus": {
            "command": "/ABSOLUTE/PATH/TO/PARENT/FOLDER/uv",
            "args": [
                "--directory",
                "/ABSOLUTE/PATH/TO/OpenManus/openmanus_server",
                "run",
                "openmanus_server.py"
            ]
        }
    }
}
```
* ! You may need to put the full path to the uv executable in the command field. You can get this by running ```which uv``` on MacOS/Linux or ```where uv``` on Windows.

This tells Claude for Desktop:

1. There's an MCP server named "openmanus"
2. To launch it by running uv --directory /ABSOLUTE/PATH/TO/OpenManus/openmanus_server run openmanus_server.py

Save the file, and restart Claude for Desktop.

Let's make sure Claude for Desktop is picking up the six tools we've exposed in our `openmanus` server. You can do this by looking for the hammer icon ![hammer icon](./assets/claude-desktop-mcp-hammer-icon.svg)

## 💻 Client Example

Check out `mcp_client_example.py` to learn how to connect to the server and call tools using the MCP client.

### Running the Client Example



## 🔒 Security Considerations

- By default, the HTTP server only listens on localhost (127.0.0.1) and is not exposed externally
- When using in production, ensure proper authentication and authorization mechanisms are in place
- The Python execution tool has timeout limits to prevent long-running code

## 📄 License

Same license as the OpenManus project 