FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["AzureAcrDemo/AzureAcrDemo.csproj", "AzureAcrDemo/"]
RUN dotnet restore "AzureAcrDemo/AzureAcrDemo.csproj"
COPY . .
WORKDIR "/src/AzureAcrDemo"
RUN dotnet publish "AzureAcrDemo.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "AzureAcrDemo.dll"]