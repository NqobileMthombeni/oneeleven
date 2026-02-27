#!/bin/bash

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Word Sort API - Test Suite${NC}"
echo -e "${BLUE}=====================================${NC}\n"

API_URL="http://localhost:3000"

# Test 1: Health Check
echo -e "${BLUE}Test 1: Health Check${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL/health")
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "200" ]; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 2: Sort Valid Word
echo -e "${BLUE}Test 2: Sort Valid Word (example)${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{"data": "example"}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q '"a","e","e","l","m","p","x"'; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 3: Sort Another Word
echo -e "${BLUE}Test 3: Sort Valid Word (typescript)${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{"data": "typescript"}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "200" ]; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 4: Missing Data Field
echo -e "${BLUE}Test 4: Error - Missing Data Field${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "400" ] && echo "$BODY" | grep -q "Missing required field"; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 5: Empty Data Field
echo -e "${BLUE}Test 5: Error - Empty Data Field${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{"data": ""}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "400" ] && echo "$BODY" | grep -q "cannot be empty"; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 6: Invalid Type (Number)
echo -e "${BLUE}Test 6: Error - Invalid Type (Number)${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{"data": 12345}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "400" ] && echo "$BODY" | grep -q "must be a string"; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

# Test 7: Case Insensitivity
echo -e "${BLUE}Test 7: Case Insensitivity (Mixed Case)${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/sort-word" \
  -H "Content-Type: application/json" \
  -d '{"data": "ExAmPlE"}')
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | head -n -1)
echo "Response: $BODY"
echo "HTTP Status: $HTTP_CODE"
if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q '"a","e","e","l","m","p","x"'; then
  echo -e "${GREEN}✓ PASSED${NC}\n"
else
  echo -e "${RED}✗ FAILED${NC}\n"
fi

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Test Suite Complete!${NC}"
echo -e "${BLUE}=====================================${NC}"
