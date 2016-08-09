'use strict'

angular
  .module 'app.student'
  .run  run-block

  run-block.$inject = ['msNavigationService']

  !function run-block (ms-navigation-service)
    nav = ms-navigation-service

    nav.save-item 'student', {
      title: '作业'
      weight: 1
      group: true
    }
    nav.save-item 'student.homework-dashboard', {
      title: '作业概览'
      weight: 1
      group: false
      state: 'app.student.homework-dashboard'
      icon: 'icon-chart-line'
    }
    nav.save-item 'student.homework-detail', {
      title: '作业详情'
      weight: 1
      group: false
      state: 'app.student.homework-detail'
      icon: 'icon-border-color'
    }
