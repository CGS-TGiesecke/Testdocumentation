# AI Audit Assist & CGS Assist – Kunden-Delivery Runbook (Fusioniert)

Dieses Dokument beschreibt den vollständigen Ablauf zur Auslieferung, technischen Einrichtung und Übergabe der AI Audit Assist / CGS Assist Plattform beim Kunden – inklusive Troubleshooting, Customization und Trainingsmodulen.

## Inhaltsverzeichnis
- 1 Überblick und Rollen
- 2 Phasenmodell der Auslieferung
  - 2.1 Pre-Sales und Anforderungsaufnahme
  - 2.2 Technische Klärung und Architektur-Workshop
  - 2.3 Auswahl des Betriebsmodells (Cloud/SaaS vs. Kunde)
- 3 Vorbereitung beim Kunden
  - 3.1 Organisatorische Voraussetzungen
  - 3.2 Technische Voraussetzungen und IT-Requirements
  - 3.3 Lizenzierung und Zugriff auf Images
- 4 Deployment-Vorbereitung je Betriebsmodell
  - 4.1 SaaS / CGS-gehostete Variante
  - 4.2 Kunden-VM / Docker Compose
  - 4.3 Kundeneigenes Kubernetes-Cluster
  - 4.4 Hybride Szenarien
- 5 Test-Deployment (Pilot / Staging)
  - 5.1 Zielsetzung des Test-Deployments
  - 5.2 Durchführung des Test-Deployments
  - 5.3 Testprotokoll und Abnahme
- 6 Go-Live
  - 6.1 Go-Live-Checkliste
  - 6.2 Umschaltstrategie
  - 6.3 Hypercare-Phase
- 7 Übergabe in den Regelbetrieb
  - 7.1 Betriebsübergabe an Kunden-IT
  - 7.2 Wartungs- und Update-Strategie
  - 7.3 Kontinuierliche Verbesserung
- 8 Customization & Branding **(NEU, aus Dokument 2)**
- 9 Troubleshooting und Fehlerbehebung **(NEU, aus Dokument 2)**
- 10 Training, Dokumentation und Support **(NEU, aus Dokument 2)**

## 1. Überblick und Rollen
* Ticketsystem / E-Mail-Verteiler für technische Themen.
* Regeltermine (Jour Fixe), Kick-off-Meeting (online/offline).
* Kommunikation: Beteiligte Rollen beim Kunden & CGS.
* Ziel: Klarheit, wer in welcher Phase welche Aufgaben übernimmt.

## 2. Phasenmodell der Auslieferung

### 2.1 Pre-Sales und Anforderungsaufnahme
* Aufnahme regulatorischer Anforderungen, Use-Cases, Datenquellen, Nutzergruppen.
* Referenz auf Onboarding-Unterlagen (`QUICK_START_ONBOARDING.md`, Templates).
* Ergänzung: Module auswählen (LLM, RAG, etc.), Lizenzmodell festlegen.

### 2.2 Technische Klärung und Architektur-Workshop
* Abgleich IT- und Security-Anforderungen/Plattformmöglichkeiten.
* Hardware-Spezifikationen prüfen (mind. 8 Cores, 16–32GB RAM, 100GB Speicher).
* Docker/Docker Compose Installation, Port-Freigaben, Firewall, SSL/TLS Zertifikate – analog technischer Requirements.

### 2.3 Auswahl des Betriebsmodells
* SaaS/Cloud, On-Premise, Kubernetes, Hybrid; Entscheidungskriterien: Skalierung, Compliance, interne Prozesse.

## 3. Vorbereitung beim Kunden

### 3.1 Organisatorische Voraussetzungen
* Definition von Kommunikationswegen, Ansprechpartner, Freigabeprozesse.

### 3.2 Technische Voraussetzungen und IT-Requirements
* Internetzugänge, Netzwerk, Ports, OS, Hardware.
* Bereitstellung Zielinfrastruktur, Docker-Engine.

### 3.3 Lizenzierung und Zugriff auf Images
* Lizenzdatei generieren, dem Kunden übermitteln und im System hinterlegen (`license/license.json`).
* Bereitstellung Container-Registry, Lizenzen/Keys, Abschluss Verträge.

## 4. Deployment-Vorbereitung je Betriebsmodell

### 4.1 SaaS / CGS-gehostete Variante
* Kundenseitige Kommunikation & SSO-Integration.
* CGS: Provisionierung, Logging, Monitoring, Backup.

### 4.2 Kunden-VM / Docker Compose
* Schritt-für-Schritt-Anleitung:  
** Anpassen `.env`-Datei, `docker-compose.yaml`, `config.yaml`, `Caddyfile`.
** Bereitstellung Deployment-Paket inkl. Beispiel-Konfigurationen und Migrationsskripten (`alembic/`).
* Services starten:
```bash
docker-compose up -d
docker-compose ps
docker-compose logs -f
curl http://localhost:8000/health
```

### 4.3 Kundeneigenes Kubernetes-Cluster
Deployment im Cluster, Anlegen Secrets, ConfigMaps, Ingress/TLS, Namespace/Ressourcen.

### 4.4 Hybride Szenarien
Kombination von Tenants/Regionen/Datenbank- und Storage-Diensten.

## 5. Test-Deployment (Pilot / Staging)

### 5.1 Zielsetzung
Security-, Logging-, Compliance-Check, fachliche/technische Validierung.

### 5.2 Durchführung
End-to-End-Tests, API-Tests, Lasttests, Performance-/Ressourcenmonitoring:
```
docker stats
curl http://localhost:8000/health
```

### 5.3 Testprotokoll und Abnahme
Abnahme durch Kunden, Priorisierung offener Punkte, Dokumentation der Testergebnisse.

## 6. Go-Live

### 6.1 Go-Live-Checkliste

Endnutzerkommunikation, Authentifizierung/SSO, Monitoring, Backup, keine kritischen Bugs.

* *Pre-Go-Live:* Tests, Backup, Monitoring, SSL/TLS-Zertifikate, Firewall, Dokumentation, Training abgeschlossen.
* *Go-Live:* Services starten, Smoke-Tests, Freigabe.
* *Post-Go-Live:* 24h Monitoring, Feedback sammeln, Metriken prüfen, Support sicherstellen.

### 6.2 Umschaltstrategie
* Variante 1: Getrennte Test-/Produktion.
* Variante 2: Test wird zu Produktion.

### 6.3 Hypercare-Phase
Enges Monitoring, Optimierung, Supportbereitschaft, Zeitraum 2–4 Wochen.

## 7. Übergabe in den Regelbetrieb

### 7.1 Betriebsübergabe an Kunden-IT
Klärung Supportwege, Vorstellung Betriebsprozesse, Dokumentenübergabe.

### 7.2 Wartungs- und Update-Strategie
Updates, Sicherheits-Patches, Wartungsfenster, Log-Rotation, Disk-Monitoring.

### 7.3 kontinuierliche Verbesserung
Erfahrungsaustausch, neue Use-Cases, regelmäßige Reviews.

### 8. Customization & Branding (NEU)
Anpassung der Corporate Identity im Produkt (z. B. CGS/ARC Version im docker compose setzen).

Modul-Konfiguration:
* LLM API: Provider & Modelle konfigurieren
* RAG API: Vector Store & Embeddings einrichten
* Workflow Engine: Automationen einrichten
* Benutzer- & Rechtemanagement: Admins, Rollen, Zugriffsrechte.

## 9. Troubleshooting und Fehlerbehebung

Häufige Probleme & Lösungen:
```
Services starten nicht:
docker-compose logs cgs_assist
docker-compose restart cgs_assist
docker-compose down
docker-compose up -d
```
* Datenbank: DATABASE_URL prüfen, Datenbank-Container läuft, Netzwerk-Konnektivität.
* Lizenz-Probleme: Lizenzdatei vorhanden, nicht abgelaufen, korrekte Module.
* Performance: RAM/CPU erhöhen, Celery Worker skalieren, Redis optimieren, DB-Indizes prüfen.

## 10. Training, Dokumentation und Support 

### 10.1 Training
Admin- und Endnutzer-Training, Q&A Sessions, Demo/Dokumentation durchgehen.

### 10.2 Dokumentation
Bereitstellung: 
* DEPLOYMENT_GUIDE.md
* QUICK_START_ONBOARDING.md
* ONBOARDING_TEMPLATE_SETUP.md.
* API-Dokumentation (Swagger/OpenAPI)
* Troubleshooting-Guide
* Backup & Restore 
* Monitoring 
* Update-Prozess 
* Performance-Tuning.

### 10.3 Support & Eskalation
* Support-Level (SLA) definieren
* Eskalations-Prozesse festlegen.
* Kontaktdatenbereitstellung (E-Mail, Telefon)
* Wartungsfenster vereinbaren.


