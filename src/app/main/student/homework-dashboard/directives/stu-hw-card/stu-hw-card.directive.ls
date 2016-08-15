'use strict'

angular
  .module 'app.student.homework-dashboard'
  .directive 'stuHwCard', ->
    stu-hw-card = {
      template-url: '/app/main/student/homework-dashboard/directives/stu-hw-card/stu-hw-card.html'
      restrict: 'E'
      scope:
        homework: '='
        score: '@'
        rank: '@'
      controller-as: 'vm'
      controller: ($scope, $md-dialog) !->
        vm = @
        vm.id = $scope.homework.homework-id
        vm.hid = '作业' + vm.id
        vm.title = $scope.homework.title
        vm.status = $scope.homework.class.status
        vm.style =
          future:
            text: '未开始'
            fg: "light-blue-fg"
          present:
            text: "进行中"
            fg: "red-fg"
          finish:
            text: "已结束"
            fg: "grey-fg"

        vm.jump = (description)!->
            window.open description   # description必须为绝对地址

        vm.showSubmitDialog = (id)!->
          $mdDialog.show {
            templateUrl: 'app/main/student/homework-dashboard/directives/stu-hw-card/submitDialog.html',
            parent: angular.element(document.body),
            clickOutsideToClose: false,
            controller: ($scope, $mdDialog, FileUploader, $interval) !->
              $scope.id = id
              $scope.showProgress = false

              $scope.cancel = !->
                $mdDialog.hide!

              pictureUploader = $scope.pictureUploader = new FileUploader {
                # url: 'upload.php',
                queueLimit: 1,
                removeAfterUpload: false
              }

              coreUploader = $scope.coreUploader = new FileUploader {
                # url: 'upload.php',
                queueLimit: 1,
                removeAfterUpload: false
              }

              $scope.clearPictureItem = !->
                pictureUploader.clearQueue!

              $scope.clearCoreItem = !->
                coreUploader.clearQueue!

              pictureUploader.onAfterAddingFile = (fileItem) !->
                $scope.picture = fileItem._file

              coreUploader.onAfterAddingFile = (fileItem) !->
                $scope.core = fileItem._file

              $scope.uploadFile = !->
                $scope.showProgress = true
                pictureUploader.uploadAll();
                coreUploader.uploadAll();

              pictureUploader.filters.push({
                  name: 'pictureFilter',
                  fn: (item) ->
                    type = '|' + item.name.slice(item.name.lastIndexOf('.') + 1,item.name.lastIndexOf('.') + 4) + '|';
                    '|jpg|png|'.indexOf(type) !== -1
              });

              coreUploader.filters.push({
                  name: 'coreFilter',
                  fn: (item) ->
                    type = '|' + item.name.slice(item.name.lastIndexOf('.') + 1,item.name.lastIndexOf('.') + 4) + '|';
                    '|zip|rar|'.indexOf(type) !== -1
              });

          }
    }
