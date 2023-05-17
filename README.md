# Bash and CSV Script Tool Manager

![Bash CSV Script Tool Manager](https://github.com/Cdaprod/Configure-Installations-with-Bash-CSV)

Welcome to the Bash CSV Script Tool Manager! This powerful, dynamic utility helps automate the deployment and setup of your tools using an easy-to-manage CSV file. No more painstakingly installing each tool manually and configuring individual files. Streamline and standardize your tool deployment with our simple yet effective solution.

## Features

- **Simple Configuration**: With a straightforward CSV format, you can easily manage and deploy a large number of tools.
- **Efficient Installation**: Install multiple tools in one command.
- **Easy Updating**: Just update the CSV file and re-run the script to add or update tools.
- **Prerequisite Handling**: Our script allows defining and handling tool prerequisites.

## How It Works

The bash script reads from the CSV file line by line. Each line represents a tool with its associated properties such as `Source`, `Destination`, `Config File`, `Repository`, `Prerequisite`, `Docker Pull`, `Docker Command`, etc. 

The script then executes the specified commands for each tool: it clones the tool from the Git repo, moves it to the specified destination, installs any prerequisites, and if specified, pulls a Docker image and runs a Docker command.

## How to Use It

Using the Bash CSV Script Tool Manager is as easy as 1, 2, 3!

1. **Set up your CSV file**: Fill in the provided CSV file with details of the tools you want to install.

    - *Asset*: The name of the tool.
    - *Src*: The source directory.
    - *Dest*: The destination directory where you want the tool installed.
    - *Config File*: The path to the configuration file.
    - *Repo*: The Git repository of the tool.
    - *Prerequisite*: Any prerequisite commands that should be run before installing the tool.
    - *Docker Pull*: The Docker image to be pulled.
    - *Command*: The Docker command to be run.
    - *Reference*: Any helpful reference links.
    - *Wordlist*: Any wordlists to be used.

2. **Run the script**: Simply run the bash script. Make sure you have appropriate permissions:

    ```bash
    chmod +x tool_installer.sh
    ./tool_installer.sh
    ```

3. **Enjoy your tools**: Sit back and relax while your tools are automatically deployed!

## Contribution

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Cdaprod/Configure-Installations-with-Bash-CSV/issues).

## Show Your Support

Give a ⭐️ if you like this project!

## Acknowledgements

- [OpenAI](https://openai.com/)
- [David Cannan](https://linkedin.com/in/cdasmkt)

Enjoy your bug bounty hunting with this automated script tool manager!
