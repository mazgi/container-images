import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

extras_require = {
    "dev_pkgs": [
        "autopep8",
        "pylint",
        "rope",
        "twine"
    ],
    "test_pkgs": [
        "pytest",
        "pytest-cov",
        "pytest-pycodestyle"
    ]
}
extras_require["dev"] = sorted(
    set(
        extras_require["dev_pkgs"]
        + extras_require["test_pkgs"]
    )
)
extras_require["test"] = sorted(
    set(
        extras_require["test_pkgs"]
    )
)

setuptools.setup(
    name="a-python-app",
    version="0.0.1",
    author="Hidenori Matsuki",
    author_email="dev@mazgi.com",
    description="A Python App",
    entry_points={
        "console_scripts": [
            "app=module.main:main"
        ]
    },
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/mazgi/container-images",
    packages=setuptools.find_packages(
        exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
    install_requires=[],
    extras_require=extras_require,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
    ],
    python_requires='>=3.6',
)
