# DHBW-Mannheim-WI2023SEB-CQRS

Dieses Projekt zeigt ein einfaches CQRS-Architekturmuster mit Erlang GenServern.

- Schreibseite: `todo_command_handler.erl`
- Leseseite: `todo_query_handler.erl`
- Start/Beispiel: `todo_app.erl`

## 🔧 Voraussetzungen

- Erlang/OTP installiert (z. B. via `brew install erlang` oder `apt install erlang`)
- Konsole/Terminal

## ▶️ Kompilieren und Ausführen

1. Wechsle ins Projektverzeichnis:
   ```bash
   cd erlang-cqrs
   ```

2. Starte die Erlang-Konsole:
   ```bash
   erl
   ```

3. Kompiliere die Module:
   ```erlang
   c(todo_command_handler).
   c(todo_query_handler).
   c(todo_app).
   ```

4. Starte die Demo:
   ```erlang
   todo_app:run_demo().
   ```

## ✅ Erwartete Ausgabe

```text
Task 1 added.
Task 2 added.
Task 1 marked as complete.

Abfrage (CQRS - Query):
Task 1: #{desc => "Milch kaufen",done => true}
Task 2: #{desc => "Hausaufgaben machen",done => false}
```

## 📦 Struktur

```text
erlang-cqrs/
├── todo_app.erl
├── todo_command_handler.erl
├── todo_query_handler.erl
└── README.md
```

## 📚 Hinweise

- In echtem CQRS erfolgt die Synchronisation via Events oder Messaging.
- Dieses Beispiel synchronisiert manuell über Funktionsaufrufe.
- Kann als Grundlage für Event-Sourcing oder verteilte Systeme dienen.

Viel Spaß mit Erlang & CQRS!
