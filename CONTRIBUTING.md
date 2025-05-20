# Contributing to MilkTea

Thank you for your interest in contributing to MilkTea! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- Use a clear and descriptive title
- Describe the exact steps to reproduce the problem
- Provide specific examples to demonstrate the steps
- Describe the behavior you observed after following the steps
- Explain which behavior you expected to see instead and why
- Include screenshots if possible
- Include the version of Java, Spring MVC, and other relevant software

### Suggesting Enhancements

If you have a suggestion for a new feature or enhancement, please:

- Use a clear and descriptive title
- Provide a detailed description of the proposed functionality
- Explain why this enhancement would be useful
- List any similar features in other applications

### Pull Requests

1. Fork the repository
2. Create a new branch for each feature or bugfix
3. Make your changes
4. Run the tests to ensure your changes don't break existing functionality
5. Submit a pull request

## Development Setup

### Prerequisites

- Java 8 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher
- Git

### Setting Up Development Environment

1. Clone the repository:

```bash
git clone https://github.com/TranKienCuong2003/MilkTea.git
cd MilkTea
```

2. Install dependencies:

```bash
mvn clean install
```

3. Configure database:

- Create a MySQL database
- Import the schema from `database/milktea.sql`
- Update database configuration in `src/main/resources/application.properties`

4. Run the application:

```bash
mvn spring-boot:run
```

## Coding Standards

### Java Code Style

- Follow the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- Use meaningful variable and method names
- Add comments for complex logic
- Keep methods small and focused
- Use proper exception handling

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### Documentation

- Update README.md if necessary
- Add comments to complex code
- Document all public APIs
- Include examples for new features

## Testing

- Write unit tests for new features
- Ensure all tests pass before submitting a pull request
- Follow the existing testing patterns in the project

## Review Process

1. All pull requests will be reviewed by at least one maintainer
2. The review process may take several days
3. You may be asked to make changes to your pull request
4. Once approved, your changes will be merged into the main branch

## Getting Help

If you need help with anything, you can:

- Open an issue
- Contact the maintainers at trankiencuong30072003@gmail.com
- Check the [documentation](README.md)

## Recognition

Contributors will be recognized in the following ways:

- Listed in the README.md file
- Added to the contributors list in the project
- Given credit in release notes

## License

By contributing to MilkTea, you agree that your contributions will be licensed under the project's [MIT License](LICENSE.md).

## Contact

For any questions about contributing, please contact:

- Email: trankiencuong30072003@gmail.com
- GitHub Issues: https://github.com/TranKienCuong2003/MilkTea/issues
