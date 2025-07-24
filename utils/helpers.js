export function parseJsonSafe(res) {
  try {
    return JSON.parse(res.body);
  } catch (_) {
    return {};
  }
}