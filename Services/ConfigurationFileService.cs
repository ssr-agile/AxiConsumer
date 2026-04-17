using System.Text.Json;
using System.Text.Json.Nodes;
using System.Xml.Linq;
using Microsoft.Extensions.Options;
using RmqConsumerService.Configuration;
using RmqConsumerService.Services.Interfaces;

namespace RmqConsumerService.Services;

public class ConfigurationFileService : IConfigurationFileService
{
    private readonly DatabaseSettings _dbSettings;
    private readonly AppConnectionSettings _appConnSettings;
    private readonly ILogger<ConfigurationFileService> _logger;

    public ConfigurationFileService(IOptions<DatabaseSettings> dbSettings,IOptions<AppConnectionSettings> appConnSettings, ILogger<ConfigurationFileService> logger)
    {
        _dbSettings = dbSettings.Value;
        _appConnSettings = appConnSettings.Value;
        _logger = logger;
    }

    public async Task<bool> UpdateConfigsAsync(string newAxiAcId, CancellationToken ct)
    {
        // 1. Load source files
        string iniPath = Path.Combine(_appConnSettings.AxpertWebScriptsPath, "AppSettings.ini");
        string xmlPath = Path.Combine(_appConnSettings.AxpertWebScriptsPath, "axapps.xml");

        // 2. Process AppSettings.ini (JSON Logic)
        var jsonContent = await File.ReadAllTextAsync(iniPath, ct);
        var root = JsonNode.Parse(jsonContent);
        CloneJsonSection(root!, "appconnections", "axiadmin", newAxiAcId);
        CloneJsonSection(root!, "appsettings", "axiadmin", newAxiAcId);
        string updatedJson = root!.ToJsonString(new JsonSerializerOptions { WriteIndented = true });

        // 3. Process axapps.xml (XML Logic)
        var xmlDoc = XDocument.Load(xmlPath);
        CloneXmlNode(xmlDoc, "axiadmin", newAxiAcId);
        string updatedXml = xmlDoc.ToString();

        string[] configDestinationPaths = [_appConnSettings.AxpertWebScriptsPath, _appConnSettings.ARMWebScriptsPath];
        // 4. Save to destinations with Backups
        foreach (var destDir in configDestinationPaths)
        {
            await BackupAndSave(destDir, "AppSettings.ini", updatedJson, ct);
            await BackupAndSave(destDir, "axapps.xml", updatedXml, ct);
        }

        return true;
    }

    private void CloneJsonSection(JsonNode root, string sectionName, string templateKey, string newKey)
    {
        var section = root[sectionName]?.AsObject();
        if (section != null && section.ContainsKey(templateKey))
        {
            var newNode = JsonNode.Parse(section[templateKey]!.ToJsonString());
            // Update dbuser specifically if needed (e.g., axiadmin\axidb -> newAcId\axidb)
            if (newNode!["dbuser"] != null)
                newNode["dbuser"] = $"{newKey}\\{newKey}";

            section[newKey] = newNode;
            _logger.LogDebug("Cloned JSON section {Section}:{NewKey}", sectionName, newKey);
        }
    }

    private void CloneXmlNode(XDocument doc, string templateName, string newName)
    {
        var connections = doc.Element("connections");
        var template = connections?.Element(templateName);
        if (template != null)
        {
            XElement newNode = new XElement(template);
            newNode.Name = newName;

            // Update dbuser element
            var dbUser = newNode.Element("dbuser");
            if (dbUser != null) dbUser.Value = $"{newName}\\{newName}";

            connections!.Add(newNode);
            _logger.LogDebug("Cloned XML node: {NewName}", newName);
        }
    }

    private async Task BackupAndSave(string directory, string fileName, string content, CancellationToken ct)
    {
        string fullPath = Path.Combine(directory, fileName);
        string backupDir = Path.Combine(directory, _appConnSettings.BackupFolderName);

        if (!Directory.Exists(backupDir)) Directory.CreateDirectory(backupDir);

        // Backup existing file if it exists
        if (File.Exists(fullPath))
        {
            string timestamp = DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss");
            string backupPath = Path.Combine(backupDir, $"{Path.GetFileNameWithoutExtension(fileName)}_{timestamp}{Path.GetExtension(fileName)}");
            File.Copy(fullPath, backupPath, true);
        }

        await File.WriteAllTextAsync(fullPath, content, ct);
        _logger.LogInformation("Updated and Backed up: {File} in {Dir}", fileName, directory);
    }
}