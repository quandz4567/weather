# Sử dụng image .NET SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Sao chép tệp dự án và cài đặt dependencies
COPY *.csproj ./
RUN dotnet restore

# Sao chép toàn bộ mã nguồn và build ứng dụng
COPY . ./
RUN dotnet publish -c Release -o /out

# Sử dụng image .NET runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "MyApi.dll"]
