
# Get Base Image (Full .NET Core SDK)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /app
EXPOSE 80
EXPOSE 443

# Copy csproj and restore
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
COPY src/*/*/*.csproj ./

# Copy everything else and build
COPY . ./

RUN dotnet publish backend-middleoffice-trafpay.sln -c Release -o /app

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build /app .
RUN ls -ltr
ENTRYPOINT ["dotnet", "backend-middleoffice-trafpay.Web.dll"]
