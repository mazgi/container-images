## Create the project

```shellsession
$ dotnet new gitignore
$ dotnet new console -o src -n DotnetApp
$ dotnet new xunit -o test -n DotnetApp.Test
$ cd test
$ dotnet add reference ../src/DotnetApp.csproj
```

## Run tests

```shellsession
$ cd test
$ dotnet test --logger:"console;verbosity=detailed"
```
