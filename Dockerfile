name: Trivy Docker Image Scan

on:
  pull_request:
    paths:
      - '**/Dockerfile*'
      - '**/*.dockerfile'

permissions:
  contents: read
  pull-requests: write
  security-events: write

jobs:
  trivy-docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build Docker Image
        run: docker build -t local-image:latest .

      - name: Trivy Docker Image Scan
        uses: reviewdog/action-trivy@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          trivy_command: image
          trivy_target: local-image:latest
          reporter: github-pr-review
          level: warning
