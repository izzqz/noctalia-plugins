import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null
  property int editWorkDuration: 25
  property int editShortBreakDuration: 5
  property int editLongBreakDuration: 15
  property int editSessionsBeforeLongBreak: 4

  property bool editAutoStartBreaks: false
  property bool editAutoStartWork: false
  property bool editCompactMode: false

  property bool editHooksEnabled: false
  property string editHookTimerStart: ""
  property string editHookTimerPause: ""
  property string editHookSessionFinish: ""
  property string editHookModeChange: ""

  spacing: Style.marginM

  onPluginApiChanged: {
    if (pluginApi) {
      loadSettings()
    }
  }

  Component.onCompleted: {

    if (pluginApi) {
      loadSettings()
    }
  }

  function loadSettings() {
    const settings = pluginApi?.pluginSettings
    const defaults = pluginApi?.manifest?.metadata?.defaultSettings

    root.editWorkDuration = settings?.workDuration ?? defaults?.workDuration ?? 25
    root.editShortBreakDuration = settings?.shortBreakDuration ?? defaults?.shortBreakDuration ?? 5
    root.editLongBreakDuration = settings?.longBreakDuration ?? defaults?.longBreakDuration ?? 15
    root.editSessionsBeforeLongBreak = settings?.sessionsBeforeLongBreak ?? defaults?.sessionsBeforeLongBreak ?? 4
    root.editAutoStartBreaks = settings?.autoStartBreaks ?? defaults?.autoStartBreaks ?? false
    root.editAutoStartWork = settings?.autoStartWork ?? defaults?.autoStartWork ?? false
    root.editCompactMode = settings?.compactMode ?? defaults?.compactMode ?? false
    root.editHooksEnabled = settings?.hooksEnabled ?? defaults?.hooksEnabled ?? false
    root.editHookTimerStart = settings?.hookTimerStart ?? defaults?.hookTimerStart ?? ""
    root.editHookTimerPause = settings?.hookTimerPause ?? defaults?.hookTimerPause ?? ""
    root.editHookSessionFinish = settings?.hookSessionFinish ?? defaults?.hookSessionFinish ?? ""
    root.editHookModeChange = settings?.hookModeChange ?? defaults?.hookModeChange ?? ""

    autoStartBreaksToggle.checked = root.editAutoStartBreaks
    autoStartWorkToggle.checked = root.editAutoStartWork
    compactModeToggle.checked = root.editCompactMode
    hooksEnabledToggle.checked = root.editHooksEnabled


  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.work-duration") || "Work Duration"
      description: pluginApi?.tr("settings.work-duration-desc") || "Duration of each work session in minutes"
    }

    NSpinBox {
      id: workDurationSpinBox
      from: 5
      to: 180
      stepSize: 5
      value: root.editWorkDuration
      onValueChanged: if (value !== root.editWorkDuration) root.editWorkDuration = value
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.short-break-duration") || "Short Break Duration"
      description: pluginApi?.tr("settings.short-break-duration-desc") || "Duration of short breaks in minutes"
    }

    NSpinBox {
      id: shortBreakSpinBox
      from: 1
      to: 60
      stepSize: 1
      value: root.editShortBreakDuration
      onValueChanged: if (value !== root.editShortBreakDuration) root.editShortBreakDuration = value
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.long-break-duration") || "Long Break Duration"
      description: pluginApi?.tr("settings.long-break-duration-desc") || "Duration of long breaks in minutes"
    }

    NSpinBox {
      id: longBreakSpinBox
      from: 5
      to: 120
      stepSize: 5
      value: root.editLongBreakDuration
      onValueChanged: if (value !== root.editLongBreakDuration) root.editLongBreakDuration = value
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.sessions-before-long-break") || "Sessions Before Long Break"
      description: pluginApi?.tr("settings.sessions-before-long-break-desc") || "Number of work sessions before a long break"
    }

    NSpinBox {
      id: sessionsSpinBox
      from: 1
      to: 10
      stepSize: 1
      value: root.editSessionsBeforeLongBreak
      onValueChanged: if (value !== root.editSessionsBeforeLongBreak) root.editSessionsBeforeLongBreak = value
    }
  }

  NDivider {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM
    Layout.bottomMargin: Style.marginM
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredHeight: autoStartBreaksToggle.implicitHeight
    
    NToggle {
      id: autoStartBreaksToggle
      anchors.fill: parent
      label: pluginApi?.tr("settings.auto-start-breaks") || "Auto-start Breaks"
      description: pluginApi?.tr("settings.auto-start-breaks-desc") || "Automatically start break timer after work session"
      checked: root.editAutoStartBreaks
    }
    
    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        root.editAutoStartBreaks = !root.editAutoStartBreaks
        autoStartBreaksToggle.checked = root.editAutoStartBreaks
      }
    }
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredHeight: autoStartWorkToggle.implicitHeight
    
    NToggle {
      id: autoStartWorkToggle
      anchors.fill: parent
      label: pluginApi?.tr("settings.auto-start-work") || "Auto-start Work"
      description: pluginApi?.tr("settings.auto-start-work-desc") || "Automatically start work timer after break"
      checked: root.editAutoStartWork
    }
    
    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        root.editAutoStartWork = !root.editAutoStartWork
        autoStartWorkToggle.checked = root.editAutoStartWork
      }
    }
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredHeight: compactModeToggle.implicitHeight
    
    NToggle {
      id: compactModeToggle
      anchors.fill: parent
      label: pluginApi?.tr("settings.compact-mode") || "Compact Mode"
      description: pluginApi?.tr("settings.compact-mode-desc") || "Hide the circular progress bar for a cleaner look"
      checked: root.editCompactMode
    }
    
    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        root.editCompactMode = !root.editCompactMode
        compactModeToggle.checked = root.editCompactMode
      }
    }
  }

  NDivider {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM
    Layout.bottomMargin: Style.marginM
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredHeight: hooksEnabledToggle.implicitHeight

    NToggle {
      id: hooksEnabledToggle
      anchors.fill: parent
      label: pluginApi?.tr("settings.hooks-enabled") || "Enable Hooks"
      description: pluginApi?.tr("settings.hooks-enabled-desc") || "Execute shell commands on timer events"
      checked: root.editHooksEnabled
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        root.editHooksEnabled = !root.editHooksEnabled
        hooksEnabledToggle.checked = root.editHooksEnabled
      }
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.hook-timer-start") || "Timer Start"
      description: pluginApi?.tr("settings.hook-timer-start-desc") || "Runs when timer starts. $1 = mode (work/short-break/long-break)"
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginS

      NTextInput {
        id: hookTimerStartInput
        Layout.fillWidth: true
        text: root.editHookTimerStart
        onTextChanged: root.editHookTimerStart = text
      }

      NButton {
        text: "Test"
        enabled: hookTimerStartInput.text !== ""
        onClicked: {
          const cmd = hookTimerStartInput.text.replace(/\$1/g, "test");
          Quickshell.execDetached(["sh", "-lc", cmd]);
        }
      }
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.hook-timer-pause") || "Timer Pause"
      description: pluginApi?.tr("settings.hook-timer-pause-desc") || "Runs when timer is paused. $1 = current mode"
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginS

      NTextInput {
        id: hookTimerPauseInput
        Layout.fillWidth: true
        text: root.editHookTimerPause
        onTextChanged: root.editHookTimerPause = text
      }

      NButton {
        text: "Test"
        enabled: hookTimerPauseInput.text !== ""
        onClicked: {
          const cmd = hookTimerPauseInput.text.replace(/\$1/g, "test");
          Quickshell.execDetached(["sh", "-lc", cmd]);
        }
      }
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.hook-session-finish") || "Session Finish"
      description: pluginApi?.tr("settings.hook-session-finish-desc") || "Runs when a session completes. $1 = finished mode"
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginS

      NTextInput {
        id: hookSessionFinishInput
        Layout.fillWidth: true
        text: root.editHookSessionFinish
        onTextChanged: root.editHookSessionFinish = text
      }

      NButton {
        text: "Test"
        enabled: hookSessionFinishInput.text !== ""
        onClicked: {
          const cmd = hookSessionFinishInput.text.replace(/\$1/g, "test");
          Quickshell.execDetached(["sh", "-lc", cmd]);
        }
      }
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NLabel {
      label: pluginApi?.tr("settings.hook-mode-change") || "Mode Change"
      description: pluginApi?.tr("settings.hook-mode-change-desc") || "Runs when switching modes. $1 = new mode"
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginS

      NTextInput {
        id: hookModeChangeInput
        Layout.fillWidth: true
        text: root.editHookModeChange
        onTextChanged: root.editHookModeChange = text
      }

      NButton {
        text: "Test"
        enabled: hookModeChangeInput.text !== ""
        onClicked: {
          const cmd = hookModeChangeInput.text.replace(/\$1/g, "test");
          Quickshell.execDetached(["sh", "-lc", cmd]);
        }
      }
    }
  }

  function saveSettings() {
    if (!pluginApi) {
      Logger.e("Pomodoro", "Cannot save settings: pluginApi is null")
      return
    }

    pluginApi.pluginSettings.workDuration = root.editWorkDuration
    pluginApi.pluginSettings.shortBreakDuration = root.editShortBreakDuration
    pluginApi.pluginSettings.longBreakDuration = root.editLongBreakDuration
    pluginApi.pluginSettings.sessionsBeforeLongBreak = root.editSessionsBeforeLongBreak
    pluginApi.pluginSettings.autoStartBreaks = root.editAutoStartBreaks
    pluginApi.pluginSettings.autoStartWork = root.editAutoStartWork
    pluginApi.pluginSettings.compactMode = root.editCompactMode
    pluginApi.pluginSettings.hooksEnabled = root.editHooksEnabled
    pluginApi.pluginSettings.hookTimerStart = root.editHookTimerStart
    pluginApi.pluginSettings.hookTimerPause = root.editHookTimerPause
    pluginApi.pluginSettings.hookSessionFinish = root.editHookSessionFinish
    pluginApi.pluginSettings.hookModeChange = root.editHookModeChange

    pluginApi.saveSettings()

    if (pluginApi.mainInstance) {
      pluginApi.mainInstance.settingsVersion++
    }


  }
}
